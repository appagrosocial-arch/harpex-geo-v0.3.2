# Funcionalidades — Harpex Geo v0.3.2

## Mapa e renderização

- MapLibre GL JS 6.7 ESM;
- satélite;
- overlay OSM;
- edifícios reais via vector tiles;
- extrusão 3D;
- LOD por zoom;
- footprint outline;
- luz global;
- sky/fog;
- terrain regional opcional;
- Micro 3D sem terrain em close;
- Topo / 3D / Baixo / Micro.

## Dados de edificações

- OSM real padrão;
- fallback Preview explícito;
- indicador de status;
- contagem de features carregadas;
- `render_height`;
- `render_min_height`;
- default visual 5,8 m quando necessário;
- proveniência exibida no inspector.

## Operação

- inspector de prédio;
- ocorrências;
- filtros;
- heatmap;
- criação de ocorrência demonstrativa;
- territórios;
- edição de vértices;
- seleção por polígono;
- timeline;
- playback temporal;
- fiscalização;
- distância;
- área;
- perfil de elevação;
- cruzamento territorial.

## IA

- painel Harpex AI;
- comandos locais em linguagem natural;
- API `window.HarpexMap`;
- source switching via tool surface;
- arquitetura pronta para backend/tool calling.

## Produção

- proposta PostGIS;
- `MultiPolygon` para buildings;
- proveniência;
- função MVT;
- servidor local sem dependência;
- validador;
- hash;
- documentação de segurança/licenças.
