-- Analysis Results Table
create table public.analysis_results (
    id uuid default uuid_generate_v4() primary key,
    file_id uuid references public.files(id),
    results jsonb default '{}'::jsonb,
    created_at timestamp with time zone default now(),
    updated_at timestamp with time zone default now()
);

-- Add RLS policies
alter table public.analysis_results enable row level security;

create policy "Users can access their own analysis results"
on public.analysis_results
for all
to authenticated
using (
    auth.uid() = (
        select user_id 
        from public.files 
        where id = analysis_results.file_id
    )
);

-- Add indexes
create index idx_analysis_results_file_id on public.analysis_results(file_id);
create index idx_analysis_results_created_at on public.analysis_results(created_at);