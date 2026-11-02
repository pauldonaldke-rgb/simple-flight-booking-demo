create table if not exists public.flight_searches (
  id bigint generated always as identity primary key,
  origin text not null check (char_length(btrim(origin)) between 2 and 100),
  destination text not null check (char_length(btrim(destination)) between 2 and 100),
  depart_date date not null,
  travelers smallint not null check (travelers between 1 and 9),
  created_at timestamptz not null default now(),
  constraint flight_searches_different_cities check (
    lower(btrim(origin)) <> lower(btrim(destination))
  )
);

alter table public.flight_searches enable row level security;

revoke all on table public.flight_searches from anon, authenticated;
grant insert on table public.flight_searches to anon;

drop policy if exists "Allow anonymous flight search submissions"
  on public.flight_searches;

create policy "Allow anonymous flight search submissions"
  on public.flight_searches
  for insert
  to anon
  with check (true);
