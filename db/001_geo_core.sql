-- Harpex Geo v0.3.2 — núcleo geoespacial recomendado para PostgreSQL + PostGIS.
-- Este arquivo não é necessário para abrir o preview HTML; ele define o caminho de produção.

create extension if not exists postgis;
create extension if not exists pgcrypto;

create table if not exists municipalities (
  id uuid primary key default gen_random_uuid(),
  ibge_code text not null unique,
  name text not null,
  uf char(2) not null,
  country_code char(2) not null default 'BR',
  geom geometry(MultiPolygon, 4326),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists buildings (
  id uuid primary key default gen_random_uuid(),
  municipality_id uuid not null references municipalities(id) on delete cascade,
  source_id text,
  source text not null,
  provider text,
  source_url text,
  license text,
  source_updated_at timestamptz,
  collected_at timestamptz not null default now(),
  geom geometry(MultiPolygon, 4326) not null,
  height_m numeric,
  min_height_m numeric not null default 0,
  floors integer,
  building_class text,
  height_method text,
  confidence text not null default 'unknown',
  is_estimated boolean not null default false,
  properties jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (municipality_id, source, source_id)
);

create index if not exists buildings_geom_gix on buildings using gist (geom);
create index if not exists buildings_municipality_idx on buildings (municipality_id);
create index if not exists buildings_source_idx on buildings (source, source_id);

create table if not exists territories (
  id uuid primary key default gen_random_uuid(),
  municipality_id uuid not null references municipalities(id) on delete cascade,
  name text not null,
  color text,
  geom geometry(MultiPolygon, 4326) not null,
  properties jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists territories_geom_gix on territories using gist (geom);

create type incident_visibility as enum ('public', 'internal', 'restricted', 'confidential');

create table if not exists incidents (
  id uuid primary key default gen_random_uuid(),
  municipality_id uuid not null references municipalities(id) on delete cascade,
  external_id text,
  type text not null,
  priority text not null,
  risk numeric,
  agency text,
  description text,
  visibility incident_visibility not null default 'internal',
  provenance text not null default 'declared',
  geom geometry(Point, 4326) not null,
  reported_at timestamptz not null default now(),
  properties jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists incidents_geom_gix on incidents using gist (geom);
create index if not exists incidents_municipality_time_idx on incidents (municipality_id, reported_at desc);

create table if not exists inspections (
  id uuid primary key default gen_random_uuid(),
  municipality_id uuid not null references municipalities(id) on delete cascade,
  building_id uuid references buildings(id) on delete set null,
  status text not null default 'pending',
  inspector_user_id uuid,
  geom geometry(Point, 4326),
  notes text,
  properties jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  completed_at timestamptz
);
create index if not exists inspections_geom_gix on inspections using gist (geom);
