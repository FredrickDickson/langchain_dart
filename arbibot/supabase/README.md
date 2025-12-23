# Supabase Database Setup

This directory contains the database schema and migrations for ArbiBot.

## Prerequisites

- Supabase CLI installed
- Supabase project created

## Local Development

### 1. Initialize Supabase (if not already done)

```bash
supabase init
```

### 2. Link to your Supabase project

```bash
supabase link --project-ref your-project-ref
```

### 3. Run migrations

```bash
supabase db push
```

Or apply migrations individually:

```bash
supabase db push --file supabase/migrations/20231223_create_profiles.sql
supabase db push --file supabase/migrations/20231223_create_chats.sql
supabase db push --file supabase/migrations/20231223_create_chat_messages.sql
supabase db push --file supabase/migrations/20231223_create_documents.sql
supabase db push --file supabase/migrations/20231223_create_storage.sql
```

## Database Schema

### Tables

1. **profiles** - User profile information
   - `id` (UUID, PK) - References auth.users
   - `email` (TEXT)
   - `full_name` (TEXT)
   - `avatar_url` (TEXT)
   - `created_at` (TIMESTAMP)
   - `updated_at` (TIMESTAMP)

2. **chats** - Chat sessions
   - `id` (UUID, PK)
   - `user_id` (UUID, FK) - References auth.users
   - `title` (TEXT)
   - `created_at` (TIMESTAMP)
   - `updated_at` (TIMESTAMP)

3. **chat_messages** - Individual messages in chats
   - `id` (UUID, PK)
   - `chat_id` (UUID, FK) - References chats
   - `role` (TEXT) - 'user' or 'ai'
   - `content` (TEXT)
   - `created_at` (TIMESTAMP)

4. **documents** - Generated legal documents
   - `id` (UUID, PK)
   - `user_id` (UUID, FK) - References auth.users
   - `title` (TEXT)
   - `content` (TEXT)
   - `document_type` (TEXT) - 'contract', 'motion', 'brief', 'other'
   - `metadata` (JSONB)
   - `created_at` (TIMESTAMP)
   - `updated_at` (TIMESTAMP)

### Storage Buckets

1. **avatars** - Public bucket for user avatars
2. **documents** - Private bucket for user documents

## Row Level Security (RLS)

All tables have RLS enabled with policies ensuring users can only access their own data.

## Triggers

- **on_auth_user_created** - Automatically creates a profile when a new user signs up
