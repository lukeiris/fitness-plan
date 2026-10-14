-- 在 Supabase Dashboard → SQL Editor 中运行一次。已运行旧版也可以安全重复执行。
create table if not exists public.workout_entries (
  user_id uuid not null references auth.users(id) on delete cascade,
  entry_date date not null,
  training_day smallint not null check (training_day between 0 and 6),
  -- 旧数据为布尔数组；新版为 { checks, session, version }，两种格式都兼容。
  checks jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, entry_date, training_day)
);

create table if not exists public.body_metrics (
  user_id uuid not null references auth.users(id) on delete cascade,
  metric_date date not null,
  weight_kg numeric(5,1) not null check (weight_kg between 30 and 200),
  updated_at timestamptz not null default now(),
  primary key (user_id, metric_date)
);

alter table public.workout_entries enable row level security;
alter table public.body_metrics enable row level security;

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

drop policy if exists "Read own body metrics" on public.body_metrics;
drop policy if exists "Insert own body metrics" on public.body_metrics;
drop policy if exists "Update own body metrics" on public.body_metrics;
drop policy if exists "Delete own body metrics" on public.body_metrics;

create policy "Read own body metrics"
on public.body_metrics for select to authenticated
using ((select auth.uid()) = user_id);

create policy "Insert own body metrics"
on public.body_metrics for insert to authenticated
with check ((select auth.uid()) = user_id);

create policy "Update own body metrics"
on public.body_metrics for update to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

create policy "Delete own body metrics"
on public.body_metrics for delete to authenticated
using ((select auth.uid()) = user_id);
