-- Vector tile de edificações para a versão hospedada da Harpex.
-- Exemplo de função PostGIS ST_AsMVT. Ajuste autenticação/tenant no backend.

create or replace function public.harpex_buildings_mvt(
  p_z integer,
  p_x integer,
  p_y integer,
  p_municipality_id uuid
) returns bytea
language sql
stable
parallel safe
as $$
with bounds as (
  select st_tileenvelope(p_z, p_x, p_y) as geom3857
), mvtgeom as (
  select
    b.id,
    b.source_id,
    b.height_m,
    b.min_height_m,
    b.floors,
    b.building_class,
    b.confidence,
    b.is_estimated,
    st_asmvtgeom(
      st_transform(b.geom, 3857),
      bounds.geom3857,
      4096,
      64,
      true
    ) as geom
  from buildings b
  cross join bounds
  where b.municipality_id = p_municipality_id
    and st_intersects(st_transform(b.geom, 3857), bounds.geom3857)
)
select st_asmvt(mvtgeom, 'building', 4096, 'geom') from mvtgeom;
$$;
