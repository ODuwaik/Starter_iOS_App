create or replace function public.delete_user(user_id uuid)
returns void
language plpgsql
security definer
as $$
begin
  -- Delete user's profile
  delete from auth.users where id = user_id;
  return;
end;
$$;

-- Grant execute permission to authenticated users
grant execute on function public.delete_user(uuid) to authenticated;
