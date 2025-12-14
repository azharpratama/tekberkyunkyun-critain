-- ============================================
-- FIX INCONSISTENT COUNTS
-- ============================================
-- This script will recalculate and update all counts
-- to ensure consistency across all stories

-- Step 1: Check current state
SELECT 
    id,
    title,
    likes_count,
    comments_count,
    (SELECT COUNT(*) FROM perpustakaan_cerita_likes WHERE story_id = perpustakaan_cerita.id) as actual_likes,
    (SELECT COUNT(*) FROM perpustakaan_cerita_comments WHERE story_id = perpustakaan_cerita.id) as actual_comments
FROM perpustakaan_cerita
ORDER BY created_at DESC
LIMIT 10;

-- Step 2: Update ALL stories with correct counts
-- This ensures every story has the right count, even if triggers weren't working before

UPDATE perpustakaan_cerita pc
SET 
    likes_count = COALESCE((
        SELECT COUNT(*) 
        FROM perpustakaan_cerita_likes 
        WHERE story_id = pc.id
    ), 0),
    comments_count = COALESCE((
        SELECT COUNT(*) 
        FROM perpustakaan_cerita_comments 
        WHERE story_id = pc.id
    ), 0);

-- Step 3: Verify the update
SELECT 
    id,
    title,
    likes_count,
    comments_count,
    (SELECT COUNT(*) FROM perpustakaan_cerita_likes WHERE story_id = perpustakaan_cerita.id) as actual_likes,
    (SELECT COUNT(*) FROM perpustakaan_cerita_comments WHERE story_id = perpustakaan_cerita.id) as actual_comments,
    CASE 
        WHEN likes_count = (SELECT COUNT(*) FROM perpustakaan_cerita_likes WHERE story_id = perpustakaan_cerita.id)
        THEN '✓ OK'
        ELSE '✗ MISMATCH'
    END as likes_status,
    CASE 
        WHEN comments_count = (SELECT COUNT(*) FROM perpustakaan_cerita_comments WHERE story_id = perpustakaan_cerita.id)
        THEN '✓ OK'
        ELSE '✗ MISMATCH'
    END as comments_status
FROM perpustakaan_cerita
ORDER BY created_at DESC;
