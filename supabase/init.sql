-- Create files table
create table if not exists public.files (
  id uuid default uuid_generate_v4() primary key,
  name text not null,
  status text not null default 'processing',
  description text,
  file_path text not null,
  file_size bigint,
  created_at timestamp with time zone default now(),
  user_id uuid references auth.users not null default auth.uid(),
  metadata jsonb
);

-- Create indexes
create index if not exists idx_files_user_id on public.files(user_id);
create index if not exists idx_files_created_at on public.files(created_at);

-- Set up RLS policies
alter table public.files enable row level security;

create policy "Users can view their own files"
on public.files for select
to authenticated
using (user_id = auth.uid());

create policy "Users can insert their own files"
on public.files for insert
to authenticated
with check (user_id = auth.uid());

-- Grant permissions
grant all on public.files to authenticated;