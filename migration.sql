-- =====================================================
-- Ceritain Database Migration
-- Complete SQL migration for Supabase
-- =====================================================

-- 1. PROFILES TABLE
-- =====================================================
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT NOT NULL,
  avatar_url TEXT,
  bio TEXT,
  total_points INTEGER DEFAULT 0,
  badge_level TEXT DEFAULT 'Bronze',
  listening_sessions_completed INTEGER DEFAULT 0,
  speaking_sessions_completed INTEGER DEFAULT 0,
  people_helped INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public profiles are viewable by everyone"
  ON profiles FOR SELECT USING (true);

CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE USING (auth.uid() = id);

-- Auto-create profile trigger
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, display_name, avatar_url)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'display_name', 'Anonymous'),
    COALESCE(NEW.raw_user_meta_data->>'avatar_url', NULL)
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- 2. RUANG BERCERITA - MATCHMAKING & CHAT
-- =====================================================

-- Matchmaking Queue
CREATE TABLE ruang_bercerita_queue (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  mode TEXT NOT NULL CHECK (mode IN ('speaker', 'listener')),
  status TEXT DEFAULT 'waiting' CHECK (status IN ('waiting', 'matched', 'cancelled')),
  joined_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id)
);

ALTER TABLE ruang_bercerita_queue ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own queue entry"
  ON ruang_bercerita_queue FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own queue entry"
  ON ruang_bercerita_queue FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own queue entry"
  ON ruang_bercerita_queue FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own queue entry"
  ON ruang_bercerita_queue FOR DELETE USING (auth.uid() = user_id);

-- Chat Sessions
CREATE TABLE ruang_bercerita_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  speaker_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  listener_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'ended')),
  started_at TIMESTAMPTZ DEFAULT NOW(),
  ended_at TIMESTAMPTZ,
  speaker_rating INTEGER CHECK (speaker_rating >= 1 AND speaker_rating <= 5),
  listener_rating INTEGER CHECK (listener_rating >= 1 AND listener_rating <= 5)
);

ALTER TABLE ruang_bercerita_sessions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Participants can view their sessions"
  ON ruang_bercerita_sessions FOR SELECT
  USING (auth.uid() = speaker_id OR auth.uid() = listener_id);

CREATE POLICY "Participants can update their sessions"
  ON ruang_bercerita_sessions FOR UPDATE
  USING (auth.uid() = speaker_id OR auth.uid() = listener_id);

-- Chat Messages
CREATE TABLE ruang_bercerita_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id UUID REFERENCES ruang_bercerita_sessions(id) ON DELETE CASCADE NOT NULL,
  sender_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  content TEXT NOT NULL,
  is_system_message BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE ruang_bercerita_messages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Session participants can view messages"
  ON ruang_bercerita_messages FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM ruang_bercerita_sessions
      WHERE ruang_bercerita_sessions.id = ruang_bercerita_messages.session_id
      AND (ruang_bercerita_sessions.speaker_id = auth.uid() OR ruang_bercerita_sessions.listener_id = auth.uid())
    )
  );

CREATE POLICY "Session participants can insert messages"
  ON ruang_bercerita_messages FOR INSERT
  WITH CHECK (
    auth.uid() = sender_id AND
    EXISTS (
      SELECT 1 FROM ruang_bercerita_sessions
      WHERE ruang_bercerita_sessions.id = session_id
      AND (ruang_bercerita_sessions.speaker_id = auth.uid() OR ruang_bercerita_sessions.listener_id = auth.uid())
      AND ruang_bercerita_sessions.status = 'active'
    )
  );

CREATE INDEX idx_ruang_bercerita_messages_session ON ruang_bercerita_messages(session_id, created_at);

-- Matchmaking Function
CREATE OR REPLACE FUNCTION match_users()
RETURNS TABLE(session_id UUID, speaker_id UUID, listener_id UUID) AS $$
DECLARE
  v_speaker_id UUID;
  v_listener_id UUID;
  v_session_id UUID;
BEGIN
  SELECT user_id INTO v_speaker_id
  FROM ruang_bercerita_queue
  WHERE mode = 'speaker' AND status = 'waiting'
  ORDER BY joined_at ASC
  LIMIT 1;

  IF v_speaker_id IS NULL THEN
    RETURN;
  END IF;

  SELECT user_id INTO v_listener_id
  FROM ruang_bercerita_queue
  WHERE mode = 'listener' AND status = 'waiting'
    AND user_id != v_speaker_id
  ORDER BY joined_at ASC
  LIMIT 1;

  IF v_listener_id IS NULL THEN
    RETURN;
  END IF;

  INSERT INTO ruang_bercerita_sessions (speaker_id, listener_id)
  VALUES (v_speaker_id, v_listener_id)
  RETURNING id INTO v_session_id;

  UPDATE ruang_bercerita_queue
  SET status = 'matched'
  WHERE user_id IN (v_speaker_id, v_listener_id);

  RETURN QUERY SELECT v_session_id, v_speaker_id, v_listener_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. RUANG AFIRMASI - AFFIRMATIONS
-- =====================================================

CREATE TABLE ruang_afirmasi (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
  -- Title and Category removed per user request
);

ALTER TABLE ruang_afirmasi ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Affirmations are viewable by everyone"
  ON ruang_afirmasi FOR SELECT USING (true);

CREATE POLICY "Authenticated users can create ruang_afirmasi"
  ON ruang_afirmasi FOR INSERT 
  WITH CHECK (auth.role() = 'authenticated');

-- Saved Affirmations
CREATE TABLE user_saved_ruang_afirmasi (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  affirmation_id UUID REFERENCES ruang_afirmasi(id) ON DELETE CASCADE NOT NULL,
  saved_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, affirmation_id)
);

ALTER TABLE user_saved_ruang_afirmasi ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own saved ruang_afirmasi"
  ON user_saved_ruang_afirmasi FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can save ruang_afirmasi"
  ON user_saved_ruang_afirmasi FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can unsave ruang_afirmasi"
  ON user_saved_ruang_afirmasi FOR DELETE USING (auth.uid() = user_id);

-- Seed Affirmations (Content Only)
INSERT INTO ruang_afirmasi (content) VALUES
  ('Kamu adalah pribadi yang berharga dan layak mendapatkan kebahagiaan.'),
  ('Kamu memiliki kekuatan untuk melewati setiap tantangan.'),
  ('Tidak apa-apa untuk tidak sempurna. Terima dirimu apa adanya.'),
  ('Banyak orang peduli dan siap membantumu. Kamu tidak sendirian.'),
  ('Setiap hari adalah kesempatan untuk memulai lagi dengan lebih baik.');

-- 4. PERPUSTAKAAN CERITA - STORY LIBRARY
-- =====================================================

-- Stories
CREATE TABLE perpustakaan_cerita (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  author_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  title TEXT NOT NULL,
  excerpt TEXT NOT NULL,
  content TEXT NOT NULL,
  cover_image_url TEXT,
  category TEXT NOT NULL,
  read_time TEXT NOT NULL,
  is_published BOOLEAN DEFAULT TRUE,
  likes_count INTEGER DEFAULT 0,
  comments_count INTEGER DEFAULT 0,
  views_count INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE perpustakaan_cerita ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Published perpustakaan_cerita are viewable by everyone"
  ON perpustakaan_cerita FOR SELECT USING (is_published = true);

CREATE POLICY "Authors can view own perpustakaan_cerita"
  ON perpustakaan_cerita FOR SELECT USING (auth.uid() = author_id);

CREATE POLICY "Authors can create perpustakaan_cerita"
  ON perpustakaan_cerita FOR INSERT WITH CHECK (auth.uid() = author_id);

CREATE POLICY "Authors can update own perpustakaan_cerita"
  ON perpustakaan_cerita FOR UPDATE USING (auth.uid() = author_id);

CREATE POLICY "Authors can delete own perpustakaan_cerita"
  ON perpustakaan_cerita FOR DELETE USING (auth.uid() = author_id);

CREATE INDEX idx_perpustakaan_cerita_published ON perpustakaan_cerita(is_published, created_at DESC);
CREATE INDEX idx_perpustakaan_cerita_category ON perpustakaan_cerita(category) WHERE is_published = true;

-- Story Likes
CREATE TABLE perpustakaan_cerita_likes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id UUID REFERENCES perpustakaan_cerita(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(story_id, user_id)
);

ALTER TABLE perpustakaan_cerita_likes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view likes"
  ON perpustakaan_cerita_likes FOR SELECT USING (true);

CREATE POLICY "Users can like perpustakaan_cerita"
  ON perpustakaan_cerita_likes FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can unlike perpustakaan_cerita"
  ON perpustakaan_cerita_likes FOR DELETE USING (auth.uid() = user_id);

CREATE INDEX idx_perpustakaan_cerita_likes_story ON perpustakaan_cerita_likes(story_id);

-- Story Comments
CREATE TABLE perpustakaan_cerita_comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id UUID REFERENCES perpustakaan_cerita(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE perpustakaan_cerita_comments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view comments"
  ON perpustakaan_cerita_comments FOR SELECT USING (true);

CREATE POLICY "Users can create comments"
  ON perpustakaan_cerita_comments FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own comments"
  ON perpustakaan_cerita_comments FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own comments"
  ON perpustakaan_cerita_comments FOR DELETE USING (auth.uid() = user_id);

CREATE INDEX idx_perpustakaan_cerita_comments_story ON perpustakaan_cerita_comments(story_id, created_at DESC);

-- 5. TRIGGERS FOR COUNTS
-- =====================================================

-- Function to update likes count
CREATE OR REPLACE FUNCTION update_story_likes_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE public.perpustakaan_cerita
        SET likes_count = likes_count + 1
        WHERE id = NEW.story_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE public.perpustakaan_cerita
        SET likes_count = GREATEST(0, likes_count - 1)
        WHERE id = OLD.story_id;
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Function to update comments count
CREATE OR REPLACE FUNCTION update_story_comments_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE public.perpustakaan_cerita
        SET comments_count = comments_count + 1
        WHERE id = NEW.story_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE public.perpustakaan_cerita
        SET comments_count = GREATEST(0, comments_count - 1)
        WHERE id = OLD.story_id;
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_story_likes_count
    AFTER INSERT OR DELETE ON public.perpustakaan_cerita_likes
    FOR EACH ROW
    EXECUTE FUNCTION update_story_likes_count();

CREATE TRIGGER trigger_update_story_comments_count
    AFTER INSERT OR DELETE ON public.perpustakaan_cerita_comments
    FOR EACH ROW
    EXECUTE FUNCTION update_story_comments_count();

-- 6. SUPABASE STORAGE BUCKETS & POLICIES
-- =====================================================

-- Create storage buckets
INSERT INTO storage.buckets (id, name, public)
VALUES 
  ('avatars', 'avatars', true),
  ('story-covers', 'story-covers', true)
ON CONFLICT (id) DO NOTHING;

-- Avatars bucket policies
CREATE POLICY "Avatars are publicly accessible"
ON storage.objects FOR SELECT
USING (bucket_id = 'avatars');

CREATE POLICY "Users can upload their own avatar"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'avatars' 
  AND auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Users can update their own avatar"
ON storage.objects FOR UPDATE
USING (
  bucket_id = 'avatars' 
  AND auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Users can delete their own avatar"
ON storage.objects FOR DELETE
USING (
  bucket_id = 'avatars' 
  AND auth.uid()::text = (storage.foldername(name))[1]
);

-- Story covers bucket policies
CREATE POLICY "Story covers are publicly accessible"
ON storage.objects FOR SELECT
USING (bucket_id = 'story-covers');

CREATE POLICY "Authenticated users can upload story covers"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'story-covers' 
  AND auth.role() = 'authenticated'
);

CREATE POLICY "Users can update their own story covers"
ON storage.objects FOR UPDATE
USING (
  bucket_id = 'story-covers' 
  AND auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Users can delete their own story covers"
ON storage.objects FOR DELETE
USING (
  bucket_id = 'story-covers' 
  AND auth.uid()::text = (storage.foldername(name))[1]
);

-- 7. ENABLE REALTIME FOR TABLES
-- =====================================================

-- Enable realtime replication for chat messages
ALTER PUBLICATION supabase_realtime ADD TABLE ruang_bercerita_messages;

-- Enable realtime replication for matchmaking queue
ALTER PUBLICATION supabase_realtime ADD TABLE ruang_bercerita_queue;

-- Enable realtime replication for chat sessions (optional but useful)
ALTER PUBLICATION supabase_realtime ADD TABLE ruang_bercerita_sessions;