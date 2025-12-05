-- ============================================
-- SUPABASE DATABASE SCHEMA
-- Perpustakaan Cerita (Story Library) Feature
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- 1. USERS TABLE (if not exists)
-- ============================================
-- Assuming you'll use Supabase Auth, but adding custom fields
CREATE TABLE IF NOT EXISTS public.users (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    username TEXT UNIQUE NOT NULL,
    full_name TEXT,
    avatar_url TEXT,
    bio TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

-- Users can read all profiles
CREATE POLICY "Users can view all profiles"
    ON public.users FOR SELECT
    USING (true);

-- Users can update their own profile
CREATE POLICY "Users can update own profile"
    ON public.users FOR UPDATE
    USING (auth.uid() = id);

-- ============================================
-- 2. STORY CATEGORIES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.story_categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.story_categories ENABLE ROW LEVEL SECURITY;

-- Everyone can read categories
CREATE POLICY "Anyone can view categories"
    ON public.story_categories FOR SELECT
    USING (true);

-- Insert default categories
INSERT INTO public.story_categories (name, description) VALUES
    ('Personal Story', 'Cerita pribadi dan pengalaman hidup'),
    ('Kesehatan Mental', 'Topik seputar kesehatan mental'),
    ('Wellness', 'Tips kesehatan dan kesejahteraan'),
    ('Work', 'Cerita dan tips seputar pekerjaan'),
    ('Relationships', 'Hubungan dan interaksi sosial')
ON CONFLICT (name) DO NOTHING;

-- ============================================
-- 3. STORIES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.stories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    excerpt TEXT,
    content TEXT NOT NULL,
    cover_image_url TEXT,
    category_id UUID REFERENCES public.story_categories(id) ON DELETE SET NULL,
    author_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
    read_time TEXT, -- e.g., "5 min read"
    likes_count INTEGER DEFAULT 0,
    comments_count INTEGER DEFAULT 0,
    views_count INTEGER DEFAULT 0,
    is_published BOOLEAN DEFAULT true,
    is_featured BOOLEAN DEFAULT false,
    published_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Constraints
    CONSTRAINT title_length CHECK (char_length(title) >= 5),
    CONSTRAINT content_length CHECK (char_length(content) >= 50)
);

-- Create indexes for better performance
CREATE INDEX idx_stories_author ON public.stories(author_id);
CREATE INDEX idx_stories_category ON public.stories(category_id);
CREATE INDEX idx_stories_published ON public.stories(is_published, published_at DESC);
CREATE INDEX idx_stories_featured ON public.stories(is_featured);

-- Enable RLS
ALTER TABLE public.stories ENABLE ROW LEVEL SECURITY;

-- Anyone can read published stories
CREATE POLICY "Anyone can view published stories"
    ON public.stories FOR SELECT
    USING (is_published = true);

-- Authors can view their own stories (even unpublished)
CREATE POLICY "Authors can view own stories"
    ON public.stories FOR SELECT
    USING (auth.uid() = author_id);

-- Authenticated users can create stories
CREATE POLICY "Authenticated users can create stories"
    ON public.stories FOR INSERT
    WITH CHECK (auth.uid() = author_id);

-- Authors can update their own stories
CREATE POLICY "Authors can update own stories"
    ON public.stories FOR UPDATE
    USING (auth.uid() = author_id);

-- Authors can delete their own stories
CREATE POLICY "Authors can delete own stories"
    ON public.stories FOR DELETE
    USING (auth.uid() = author_id);

-- ============================================
-- 4. STORY LIKES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.story_likes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    story_id UUID REFERENCES public.stories(id) ON DELETE CASCADE NOT NULL,
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Ensure one like per user per story
    UNIQUE(story_id, user_id)
);

-- Create index
CREATE INDEX idx_story_likes_story ON public.story_likes(story_id);
CREATE INDEX idx_story_likes_user ON public.story_likes(user_id);

-- Enable RLS
ALTER TABLE public.story_likes ENABLE ROW LEVEL SECURITY;

-- Users can view all likes
CREATE POLICY "Anyone can view likes"
    ON public.story_likes FOR SELECT
    USING (true);

-- Authenticated users can like stories
CREATE POLICY "Authenticated users can like stories"
    ON public.story_likes FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Users can remove their own likes
CREATE POLICY "Users can remove own likes"
    ON public.story_likes FOR DELETE
    USING (auth.uid() = user_id);

-- ============================================
-- 5. STORY BOOKMARKS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.story_bookmarks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    story_id UUID REFERENCES public.stories(id) ON DELETE CASCADE NOT NULL,
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Ensure one bookmark per user per story
    UNIQUE(story_id, user_id)
);

-- Create index
CREATE INDEX idx_story_bookmarks_story ON public.story_bookmarks(story_id);
CREATE INDEX idx_story_bookmarks_user ON public.story_bookmarks(user_id);

-- Enable RLS
ALTER TABLE public.story_bookmarks ENABLE ROW LEVEL SECURITY;

-- Users can view their own bookmarks
CREATE POLICY "Users can view own bookmarks"
    ON public.story_bookmarks FOR SELECT
    USING (auth.uid() = user_id);

-- Authenticated users can bookmark stories
CREATE POLICY "Authenticated users can bookmark stories"
    ON public.story_bookmarks FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Users can remove their own bookmarks
CREATE POLICY "Users can remove own bookmarks"
    ON public.story_bookmarks FOR DELETE
    USING (auth.uid() = user_id);

-- ============================================
-- 6. STORY COMMENTS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.story_comments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    story_id UUID REFERENCES public.stories(id) ON DELETE CASCADE NOT NULL,
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
    content TEXT NOT NULL,
    parent_comment_id UUID REFERENCES public.story_comments(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    CONSTRAINT comment_length CHECK (char_length(content) >= 1)
);

-- Create indexes
CREATE INDEX idx_story_comments_story ON public.story_comments(story_id);
CREATE INDEX idx_story_comments_user ON public.story_comments(user_id);
CREATE INDEX idx_story_comments_parent ON public.story_comments(parent_comment_id);

-- Enable RLS
ALTER TABLE public.story_comments ENABLE ROW LEVEL SECURITY;

-- Anyone can read comments on published stories
CREATE POLICY "Anyone can view comments"
    ON public.story_comments FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM public.stories
            WHERE stories.id = story_id AND stories.is_published = true
        )
    );

-- Authenticated users can create comments
CREATE POLICY "Authenticated users can create comments"
    ON public.story_comments FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Users can update their own comments
CREATE POLICY "Users can update own comments"
    ON public.story_comments FOR UPDATE
    USING (auth.uid() = user_id);

-- Users can delete their own comments
CREATE POLICY "Users can delete own comments"
    ON public.story_comments FOR DELETE
    USING (auth.uid() = user_id);

-- ============================================
-- 7. TRIGGERS FOR AUTOMATIC UPDATES
-- ============================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for users table
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON public.users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Trigger for stories table
CREATE TRIGGER update_stories_updated_at
    BEFORE UPDATE ON public.stories
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Trigger for comments table
CREATE TRIGGER update_comments_updated_at
    BEFORE UPDATE ON public.story_comments
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- 8. FUNCTIONS FOR COUNTING
-- ============================================

-- Function to update likes count
CREATE OR REPLACE FUNCTION update_story_likes_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE public.stories
        SET likes_count = likes_count + 1
        WHERE id = NEW.story_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE public.stories
        SET likes_count = GREATEST(0, likes_count - 1)
        WHERE id = OLD.story_id;
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Trigger for likes count
CREATE TRIGGER trigger_update_story_likes_count
    AFTER INSERT OR DELETE ON public.story_likes
    FOR EACH ROW
    EXECUTE FUNCTION update_story_likes_count();

-- Function to update comments count
CREATE OR REPLACE FUNCTION update_story_comments_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE public.stories
        SET comments_count = comments_count + 1
        WHERE id = NEW.story_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE public.stories
        SET comments_count = GREATEST(0, comments_count - 1)
        WHERE id = OLD.story_id;
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Trigger for comments count
CREATE TRIGGER trigger_update_story_comments_count
    AFTER INSERT OR DELETE ON public.story_comments
    FOR EACH ROW
    EXECUTE FUNCTION update_story_comments_count();

-- ============================================
-- 9. VIEWS FOR EASIER QUERIES
-- ============================================

-- View for stories with author and category details
CREATE OR REPLACE VIEW public.stories_with_details AS
SELECT 
    s.id,
    s.title,
    s.excerpt,
    s.content,
    s.cover_image_url,
    s.read_time,
    s.likes_count,
    s.comments_count,
    s.views_count,
    s.is_published,
    s.is_featured,
    s.published_at,
    s.created_at,
    s.updated_at,
    -- Author details
    u.id as author_id,
    u.username as author_username,
    u.full_name as author_name,
    u.avatar_url as author_avatar,
    -- Category details
    c.id as category_id,
    c.name as category_name
FROM public.stories s
LEFT JOIN public.users u ON s.author_id = u.id
LEFT JOIN public.story_categories c ON s.category_id = c.id;

-- Grant access to view
GRANT SELECT ON public.stories_with_details TO authenticated, anon;

-- ============================================
-- 10. SAMPLE DATA (Optional - for testing)
-- ============================================

-- Uncomment below to insert sample data
/*
-- Insert sample user (you'd normally use Supabase Auth for this)
INSERT INTO public.users (id, username, full_name, avatar_url, bio)
VALUES 
    (uuid_generate_v4(), 'test_user', 'Test User', 'https://example.com/avatar.png', 'A test user for demo')
ON CONFLICT (username) DO NOTHING;

-- Get the test user id
DO $$
DECLARE
    test_user_id UUID;
    category_id UUID;
BEGIN
    SELECT id INTO test_user_id FROM public.users WHERE username = 'test_user' LIMIT 1;
    SELECT id INTO category_id FROM public.story_categories WHERE name = 'Personal Story' LIMIT 1;
    
    -- Insert sample story
    INSERT INTO public.stories (title, excerpt, content, category_id, author_id, read_time)
    VALUES (
        'Sample Story Title',
        'This is a sample excerpt for the story...',
        'This is the full content of the sample story. It needs to be at least 50 characters long to meet the validation requirements.',
        category_id,
        test_user_id,
        '3 min read'
    );
END $$;
*/

-- ============================================
-- DONE!
-- ============================================
-- Run this SQL in your Supabase SQL Editor
-- Make sure to enable Row Level Security (RLS) in your project settings
