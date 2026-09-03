# Caminho para produção

## MVP

A v0.3.2 resolve o front geoespacial e demonstra o uso de footprint real OSM.

## Próximo estágio

### Dados
1. importar OSM/Overture em batch;
2. guardar `source`, `provider`, licença e timestamps;
3. armazenar PostGIS MultiPolygon;
4. enriquecer altura com fonte/estimativa explícita;
5. gerar MVT/PMTiles.

### API
- `/api/geo/buildings/{z}/{x}/{y}.mvt`
- `/api/incidents`
- `/api/territories`
- `/api/inspections`
- `/api/ai/tools`

### Segurança
- autenticação;
- RLS por município;
- papéis de operador/gestor/admin;
- auditoria.

### Observabilidade
- erro de tiles;
- latência da API;
- FPS aproximado do mapa;
- número de features visíveis;
- falhas WebGL;
- métricas de tool calls da IA.
