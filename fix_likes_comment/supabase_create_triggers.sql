-- ============================================
-- CHECK AND CREATE TRIGGERS
-- Run this to verify and create the counting triggers
-- ============================================

-- First, check if the trigger functions exist
-- (You should see the function definitions if they exist)

-- If the functions don't exist, create them:

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

-- Drop existing triggers if they exist (to avoid duplicates)
DROP TRIGGER IF EXISTS trigger_update_story_likes_count ON public.perpustakaan_cerita_likes;
DROP TRIGGER IF EXISTS trigger_update_story_comments_count ON public.perpustakaan_cerita_comments;

-- Create triggers
CREATE TRIGGER trigger_update_story_likes_count
    AFTER INSERT OR DELETE ON public.perpustakaan_cerita_likes
    FOR EACH ROW
    EXECUTE FUNCTION update_story_likes_count();

CREATE TRIGGER trigger_update_story_comments_count
    AFTER INSERT OR DELETE ON public.perpustakaan_cerita_comments
    FOR EACH ROW
    EXECUTE FUNCTION update_story_comments_count();

-- ============================================
-- VERIFICATION QUERY
-- ============================================
-- Run this to check if triggers are created:
SELECT 
    trigger_name,
    event_object_table,
    action_statement
FROM information_schema.triggers
WHERE event_object_table IN ('perpustakaan_cerita_likes', 'perpustakaan_cerita_comments');
