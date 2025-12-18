# Ceritain Database Schema - ERD

## Mermaid Diagram

```mermaid
erDiagram
    %% User Authentication & Profiles
    auth_users ||--|| profiles : "auto-creates"
    
    profiles {
        uuid id PK
        text display_name
        text avatar_url
        text bio
        int total_points
        text badge_level
        int listening_sessions_completed
        int speaking_sessions_completed
        int people_helped
        timestamptz created_at
        timestamptz updated_at
    }

    %% Ruang Bercerita (Chat/Matchmaking)
    profiles ||--o{ ruang_bercerita_queue : "joins"
    profiles ||--o{ ruang_bercerita_sessions : "speaks"
    profiles ||--o{ ruang_bercerita_sessions : "listens"
    profiles ||--o{ ruang_bercerita_messages : "sends"
    
    ruang_bercerita_queue {
        uuid id PK
        uuid user_id FK
        text mode "speaker/listener"
        text status "waiting/matched/cancelled"
        timestamptz joined_at
    }
    
    ruang_bercerita_sessions {
        uuid id PK
        uuid speaker_id FK
        uuid listener_id FK
        text status "active/ended"
        timestamptz started_at
        timestamptz ended_at
        int speaker_rating "1-5"
        int listener_rating "1-5"
    }
    
    ruang_bercerita_sessions ||--o{ ruang_bercerita_messages : "contains"
    
    ruang_bercerita_messages {
        uuid id PK
        uuid session_id FK
        uuid sender_id FK
        text content
        bool is_system_message
        timestamptz created_at
    }

    %% Perpustakaan Cerita (Story Library)
    profiles ||--o{ perpustakaan_cerita : "authors"
    profiles ||--o{ perpustakaan_cerita_likes : "likes"
    profiles ||--o{ perpustakaan_cerita_comments : "comments"
    
    perpustakaan_cerita {
        uuid id PK
        uuid author_id FK
        text title
        text excerpt
        text content
        text cover_image_url
        text category
        text read_time
        bool is_published
        int likes_count "Optimized count"
        int comments_count "Optimized count"
        int views_count
        timestamptz created_at
        timestamptz updated_at
    }
    
    perpustakaan_cerita ||--o{ perpustakaan_cerita_likes : "has"
    perpustakaan_cerita ||--o{ perpustakaan_cerita_comments : "has"
    
    perpustakaan_cerita_likes {
        uuid id PK
        uuid story_id FK
        uuid user_id FK
        timestamptz created_at
    }
    
    perpustakaan_cerita_comments {
        uuid id PK
        uuid story_id FK
        uuid user_id FK
        text content
        timestamptz created_at
        timestamptz updated_at
    }

    %% Ruang Afirmasi (Affirmations)
    profiles ||--o{ user_saved_ruang_afirmasi : "saves"
    ruang_afirmasi ||--o{ user_saved_ruang_afirmasi : "saved-by"
    
    ruang_afirmasi {
        uuid id PK
        text content
        timestamptz created_at
    }
    
    user_saved_ruang_afirmasi {
        uuid id PK
        uuid user_id FK
        uuid affirmation_id FK
        timestamptz saved_at
    }
```

## Table Summary

### 1. **Profiles & Authentication**
- `profiles` - User profiles with gamification stats

### 2. **Ruang Bercerita** (Mental Health Chat)
- `ruang_bercerita_queue` - Matchmaking queue for speakers/listeners
- `ruang_bercerita_sessions` - Active chat sessions
- `ruang_bercerita_messages` - Chat messages within sessions

### 3. **Perpustakaan Cerita** (Story Library)
- `perpustakaan_cerita` - User-generated stories
- `perpustakaan_cerita_likes` - Story likes
- `perpustakaan_cerita_comments` - Story comments

### 4. **Ruang Afirmasi** (Affirmations)
- `ruang_afirmasi` - Affirmation messages
- `user_saved_ruang_afirmasi` - Users' saved affirmations

## Key Features

### Security (RLS Policies)
- ✅ Users can only update their own profiles
- ✅ Only session participants can view messages
- ✅ Authors can manage their own stories
- ✅ Users can only save/unsave their own affirmations

### Real-time Features
- ✅ Live chat messaging (`ruang_bercerita_messages`)
- ✅ Matchmaking queue updates (`ruang_bercerita_queue`)

### Gamification
- 📊 Points system
- 🏆 Badge levels (Bronze → Gold)
- 📈 Session completion tracking
- 💚 People helped counter
