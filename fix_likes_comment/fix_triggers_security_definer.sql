-- ============================================
-- FIX: ADD SECURITY DEFINER TO TRIGGER FUNCTIONS
-- ============================================
-- Issue: Likes and comments counts were not updating for non-author users
-- Cause: RLS policies on 'perpustakaan_cerita' table prevented updates from other users
-- Fix: Add SECURITY DEFINER to trigger functions to bypass RLS for the count update

-- Function to update likes count (with SECURITY DEFINER)
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
    RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to update comments count (with SECURITY DEFINER)
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
    RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
