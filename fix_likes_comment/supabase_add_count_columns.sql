-- ============================================
-- ADD MISSING COLUMNS TO perpustakaan_cerita
-- ============================================
-- This script adds the likes_count and comments_count columns
-- that are needed for the counting feature

-- Add likes_count column if it doesn't exist
ALTER TABLE public.perpustakaan_cerita 
ADD COLUMN IF NOT EXISTS likes_count INTEGER DEFAULT 0;

-- Add comments_count column if it doesn't exist
ALTER TABLE public.perpustakaan_cerita 
ADD COLUMN IF NOT EXISTS comments_count INTEGER DEFAULT 0;

-- Add views_count column if it doesn't exist (optional, for future use)
ALTER TABLE public.perpustakaan_cerita 
ADD COLUMN IF NOT EXISTS views_count INTEGER DEFAULT 0;

-- ============================================
-- UPDATE EXISTING COUNTS (if you have existing data)
-- ============================================
-- This will count existing likes and update the likes_count column
UPDATE public.perpustakaan_cerita pc
SET likes_count = (
    SELECT COUNT(*) 
    FROM public.perpustakaan_cerita_likes 
    WHERE story_id = pc.id
);

-- This will count existing comments and update the comments_count column
UPDATE public.perpustakaan_cerita pc
SET comments_count = (
    SELECT COUNT(*) 
    FROM public.perpustakaan_cerita_comments 
    WHERE story_id = pc.id
);

-- ============================================
-- VERIFICATION
-- ============================================
-- Check if columns were added successfully
SELECT column_name, data_type, column_default
FROM information_schema.columns 
WHERE table_name = 'perpustakaan_cerita' 
  AND column_name IN ('likes_count', 'comments_count', 'views_count')
ORDER BY column_name;
