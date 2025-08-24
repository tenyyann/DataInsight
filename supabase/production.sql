-- More secure policies for production
create policy "enable_auth_access"
on public.files
for all
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- Secure storage access
alter table storage.buckets 
update set public = false 
where id = 'datainsight';

create policy "enable_auth_storage_access"
on storage.objects
for all
to authenticated
using (bucket_id = 'datainsight' and auth.uid() = (
  select user_id from public.files 
  where file_path = storage.objects.name
))
with check (bucket_id = 'datainsight');