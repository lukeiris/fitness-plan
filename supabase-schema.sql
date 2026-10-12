-- 在 Supabase Dashboard → SQL Editor 中运行一次。
create table if not exists public.workout_entries (
  user_id uuid not null references auth.users(id) on delete cascade,
  entry_date date not null,
  training_day smallint not null check (training_day between 0 and 6),
  checks jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, entry_date, training_day)
);

alter table public.workout_entries enable row level security;

drop policy if exists "Read own workout entries" on public.workout_entries;
create policy "Read own workout entries"
on public.workout_entries for select to authenticated
using ((select auth.uid()) = user_id);

drop policy if exists "Insert own workout entries" on public.workout_entries;
create policy "Insert own workout entries"
on public.workout_entries for insert to authenticated
with check ((select auth.uid()) = user_id);

drop policy if exists "Update own workout entries" on public.workout_entries;
create policy "Update own workout entries"
on public.workout_entries for update to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

drop policy if exists "Delete own workout entries" on public.workout_entries;
create policy "Delete own workout entries"
on public.workout_entries for delete to authenticated
using ((select auth.uid()) = user_id);
