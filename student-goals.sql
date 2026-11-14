-- =====================================================================
--  UTKARSH ACADEMY — Student goals (set by staff, shown on the dashboard)
--  Run once in Supabase → SQL Editor. Safe to re-run.
-- =====================================================================

create table if not exists public.student_goals (
  id         uuid primary key default gen_random_uuid(),
  class_key  text not null default 'all',      -- class11 | class12 | cuet | class12cuet | all
  email      text,                             -- null = goal for the whole class
  title      text not null,
  metric     text not null default 'custom',   -- tests | avg_score | best_score | dayd | lectures | copies | custom
  target     numeric,
  progress   numeric,                          -- only for metric = custom (0–100, staff-updated)
  due_date   date,
  note       text,
  created_at timestamptz not null default now()
);
create index if not exists student_goals_class_idx on public.student_goals (class_key);
create index if not exists student_goals_email_idx on public.student_goals (lower(email));

alter table public.student_goals enable row level security;

-- Students see class-wide goals + goals set for their own email. Staff see all.
drop policy if exists goals_read on public.student_goals;
create policy goals_read on public.student_goals
  for select to authenticated
  using (email is null or lower(email) = lower(auth.jwt() ->> 'email') or public.is_admin());

-- Only staff can add / edit / delete goals.
drop policy if exists goals_admin on public.student_goals;
create policy goals_admin on public.student_goals
  for all using (public.is_admin()) with check (public.is_admin());
