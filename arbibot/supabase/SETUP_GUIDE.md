# ArbiBot Supabase Setup Guide

## Step 1: Link Your Supabase Project

First, you need to link your local project to your Supabase project. You can find your project reference in your Supabase dashboard URL (it's the part after `/project/`).

```bash
# Navigate to the arbibot directory
cd c:\Users\Administrator\Documents\Projects\Arbibot\langchain_dart\arbibot

# Link to your Supabase project (replace YOUR_PROJECT_REF with your actual project reference)
supabase link --project-ref YOUR_PROJECT_REF
```

When prompted, enter your database password (from your Supabase project settings).

## Step 2: Apply Database Migrations

After linking, apply all migrations to create the database schema:

```bash
# Apply all migrations at once
supabase db push

# Or apply them individually in order:
supabase db push --file supabase/migrations/20231223_create_profiles.sql
supabase db push --file supabase/migrations/20231223_create_chats.sql
supabase db push --file supabase/migrations/20231223_create_chat_messages.sql
supabase db push --file supabase/migrations/20231223_create_documents.sql
supabase db push --file supabase/migrations/20231223_create_storage.sql
```

## Step 3: Verify the Setup

Check that all tables were created successfully:

```bash
supabase db diff
```

## Step 4: Update Your .env File

Make sure your `.env` file has the correct Supabase credentials:

```env
SUPABASE_URL=https://YOUR_PROJECT_REF.supabase.co
SUPABASE_ANON_KEY=your_anon_key_here
OPENAI_API_KEY=your_openai_api_key_here
```

You can find these values in your Supabase project settings under "API".

## Alternative: Using Supabase Dashboard

If you prefer to use the Supabase dashboard:

1. Go to your Supabase project dashboard
2. Navigate to the SQL Editor
3. Copy and paste each migration file content (in order):
   - `20231223_create_profiles.sql`
   - `20231223_create_chats.sql`
   - `20231223_create_chat_messages.sql`
   - `20231223_create_documents.sql`
   - `20231223_create_storage.sql`
4. Run each SQL script

## Troubleshooting

### Error: "relation already exists"
If you see this error, it means the table already exists. You can either:
- Drop the existing tables and re-run the migrations
- Skip the migration for that specific table

### Error: "permission denied"
Make sure you're using the correct database password and have the necessary permissions.

### Verify Tables
After running migrations, verify in the Supabase dashboard:
- Go to Table Editor
- You should see: `profiles`, `chats`, `chat_messages`, `documents`
- Go to Storage
- You should see buckets: `avatars`, `documents`
