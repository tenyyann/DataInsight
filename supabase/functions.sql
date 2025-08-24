create or replace function get_column_info(table_name text)
returns table (column_name text, data_type text)
language plpgsql
security definer
as $$
begin
  return query
  select c.column_name::text, c.data_type::text
  from information_schema.columns c
  where c.table_schema = 'public'
    and c.table_name = table_name;
end;
$$;

grant execute on function get_column_info to authenticated;