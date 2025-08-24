-- First, disable RLS temporarily to clean up
alter table if exists public.files disable row level security;

-- Clean up everything
drop policy if exists "enable_all_access" on public.files;
drop policy if exists "enable_storage_access" on storage.objects;
drop table if exists public.files cascade;

-- Create files table
create table public.files (
  id uuid default uuid_generate_v4() primary key,
  name text not null,
  status text not null default 'processing',
  description text,
  file_path text not null,
  file_size bigint,
  created_at timestamp with time zone default now(),
  user_id uuid,  -- Remove default constraint for more permissive access
  column_mapping jsonb default '[]'::jsonb
);

-- Create indexes
create index idx_files_user_id on public.files(user_id);
create index idx_files_created_at on public.files(created_at);

-- Enable RLS and create development policy
alter table public.files enable row level security;

create policy "enable_all_access"
on public.files
for all
to public  -- Changed to public instead of authenticated for development
using (true)
with check (true);

-- Storage setup with more permissive policy
insert into storage.buckets (id, name, public)
values ('datainsight', 'DataInsight Files', true)  -- Set public to true
on conflict (id) do nothing;

create policy "enable_storage_access"
on storage.objects
for all
to public  -- Changed to public for development
using (true)
with check (bucket_id = 'datainsight');

-- Grant all permissions
grant all on public.files to anon;
grant all on public.files to authenticated;
grant all on storage.objects to anon;
grant all on storage.objects to authenticated;