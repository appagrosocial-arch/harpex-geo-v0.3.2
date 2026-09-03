# Arquitetura — Harpex Geo v0.3.2

## Objetivo

Separar claramente a experiência geoespacial, os dados, a inteligência e a persistência.

```text
Operador
  ↓
Harpex Geo UI
  ↓
MapLibre GL JS
  ├─ satélite / base
  ├─ OpenFreeMap / OpenMapTiles (OSM real)
  ├─ territórios
  ├─ ocorrências
  ├─ fiscalizações
  └─ ferramentas espaciais
  ↓
window.HarpexMap
  ↓
Harpex AI / tool calling futuro
  ↓
API Harpex
  ↓
PostgreSQL + PostGIS
  ↓
Vector Tiles / PMTiles
```

## Camada visual

A aplicação usa MapLibre GL JS 6.7 em ESM. O preview é um HTML único para reduzir dependências de build e facilitar validação visual.

### Edificações reais

A v0.3.2 utiliza a fonte vetorial pública do OpenFreeMap:

```text
https://tiles.openfreemap.org/planet
```

Schema OpenMapTiles:

```text
source-layer: building
render_height
render_min_height
```

O footprint é do OpenStreetMap. A altura pode ser informada/derivada pelo pipeline OpenMapTiles; se não houver valor utilizável, a interface usa 5,8 m como **altura visual padrão**, sem classificar esse valor como altura oficial.

## Modo fallback

A camada procedimental da v0.3.1 continua no arquivo apenas como fallback explícito. Ela nunca é apresentada como dado real.

## Micro 3D

Em zoom alto o sistema:

- desativa terrain automaticamente;
- mantém satélite com alta opacidade;
- reforça o overlay viário;
- aumenta levemente a profundidade visual das extrusões;
- exibe contorno de footprint.

A ideia é priorizar a leitura de edificação e rua, não relevo regional.

## Produção

No produto final, a fonte pública não deve ser o único ponto de dependência operacional. A arquitetura recomendada é:

1. ingestão OSM/Overture;
2. normalização e proveniência;
3. PostGIS;
4. geração de vector tiles;
5. CDN/object storage;
6. MapLibre.
