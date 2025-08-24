-- Create analysis_results table
create table if not exists public.analysis_results (
    id uuid default uuid_generate_v4() primary key,
    file_id uuid references public.files(id) on delete cascade,
    status text not null default 'pending',
    results jsonb default '{
        "summary": {
            "rowCount": 0,
            "columnCount": 0,
            "dataQualityScore": 0
        },
        "columns": [],
        "insights": []
    }'::jsonb,
    created_at timestamp with time zone default now(),
    updated_at timestamp with time zone default now()
);

-- Create indexes
create index idx_analysis_results_file_id on public.analysis_results(file_id);
create index idx_analysis_results_status on public.analysis_results(status);

-- Enable RLS
alter table public.analysis_results enable row level security;

-- Create RLS policies
create policy "Users can view their own analysis results"
on public.analysis_results
for select
to authenticated
using (
    auth.uid() = (
        select user_id 
        from public.files 
        where id = file_id
    )
);

create policy "Users can update their own analysis results"
on public.analysis_results
for update
to authenticated
using (
    auth.uid() = (
        select user_id 
        from public.files 
        where id = file_id
    )
);

-- Create trigger for updated_at
create or replace function update_updated_at_column()
returns trigger as $$
begin
    new.updated_at = now();
    return new;
end;
$$ language plpgsql;

create trigger update_analysis_results_updated_at
    before update on public.analysis_results
    for each row
    execute function update_updated_at_column();