# Harpex Geo v0.3.2 — Real 3D Urbano

> Centro operacional urbano 3D para Parnaíba, com **edificações reais do OpenStreetMap via OpenFreeMap/OpenMapTiles**, Micro 3D para casas e prédios baixos, ferramentas territoriais e fallback explícito de demonstração.

---

## 1. O que esta versão resolve

A v0.3.2 foi criada para resolver exatamente o problema observado no zoom próximo:

> ao aproximar, o mapa não pode virar uma superfície cinza ou perder leitura de casas; o operador precisa enxergar **casas e pequenos prédios com volume e profundidade**.

A solução desta versão muda o foco de “cidade 3D de demonstração” para **malha urbana real + visualização operacional**.

### Mudanças principais

- **footprints reais de edificações** vindos do OpenStreetMap;
- vector tiles via OpenFreeMap/OpenMapTiles, sem chave de API;
- `source-layer: building`;
- extrusão por `render_height` quando disponível;
- `render_min_height` para edifícios elevados/partes de edifício quando fornecido;
- altura visual padrão quando a fonte não possui altura;
- indicador de saúde da fonte real;
- contagem de footprints reais carregados no viewport;
- botão para alternar explicitamente entre **OSM real** e **Preview**;
- novo preset de câmera **Micro**;
- terrain desligado por padrão;
- terrain retirado automaticamente em close urbano;
- contornos de footprint em zoom alto;
- luz global ajustada para melhorar leitura de fachadas;
- sky/fog discreto para câmera inclinada;
- seleção, fiscalização, inspector, timeline e Harpex AI preservados.

---

# 2. Quick start — 30 segundos

## Windows

Dê dois cliques em:

```text
ABRIR_HARPEX_GEO_V032.bat
```

O navegador abrirá:

```text
http://127.0.0.1:8787/
```

## Node.js

Requer Node 20+.

```bash
npm run preview
```

Depois:

```text
http://127.0.0.1:8787/
```

## Python

Sem Node:

```bash
python -m http.server 8787
```

Abra:

```text
http://127.0.0.1:8787/
```

---

# 3. Arquivos principais

```text
harpex_geo_v032/
├── index.html
├── harpex-geo.html
├── README.md
├── LICENSES_AND_ATTRIBUTION.md
├── package.json
├── ABRIR_HARPEX_GEO_V032.bat
├── ABRIR_HARPEX_GEO_V032.command
│
├── preview/
│   ├── harpex-geo-v03.2-real3d.html    ← PREVIEW PRINCIPAL
│   ├── harpex-geo-v03.1-micro3d.html   ← versão anterior
│   └── referencia-visual-3d.png
│
├── config/
│   └── municipality.json
│
├── db/
│   ├── 001_geo_core.sql
│   └── 002_vector_tiles.sql
│
├── scripts/
│   ├── serve.mjs
│   ├── validate.mjs
│   └── hash.mjs
│
└── docs/
    ├── ARCHITECTURE.md
    ├── DATA_PROVENANCE.md
    ├── MICRO3D_RENDERING.md
    ├── PERFORMANCE.md
    ├── PRODUCTION.md
    ├── SECURITY.md
    └── TROUBLESHOOTING.md
```

---

# 4. Edificações reais

## Fonte

A camada real usa:

```text
https://tiles.openfreemap.org/planet
```

com schema OpenMapTiles:

```text
source-layer = building
```

A geometria vem do OpenStreetMap.

## Altura

A aplicação tenta usar:

```text
render_height
render_min_height
```

Quando `render_height` existe, o inspector indica a altura como proveniente/derivada do pipeline OpenMapTiles.

Quando não existe altura útil, a aplicação usa:

```text
5,8 m
```

como **altura visual padrão para renderização**.

Isso não é apresentado como altura oficial.

---

# 5. Modos de edificações

No canto superior direito há:

```text
EDIFICAÇÕES   OSM real | Preview
```

## OSM real

Padrão.

- footprint real;
- carregamento por vector tile;
- melhor escalabilidade;
- atributos de altura quando disponíveis;
- source health visível na interface.

## Preview

Fallback explícito.

- usa a malha procedimental local;
- funciona para demonstração visual;
- não representa cadastro oficial;
- útil quando a conexão externa está indisponível.

A aplicação **não mistura silenciosamente** os dois modos.

---

# 6. Micro 3D

O preset **Micro** foi criado para o cenário mostrado no screenshot: observar bairro, casas, pequenos prédios e quadras com profundidade.

Configuração aproximada:

```text
zoom:    16.15
pitch:   58°
bearing: 28°
```

### O que acontece no close

Acima de aproximadamente `z15.15`:

- terrain é removido;
- hillshade some;
- satélite fica mais nítido;
- overlay viário fica mais legível;
- edifícios continuam extrudados;
- contornos de footprint aparecem;
- a profundidade visual das extrusões aumenta de forma moderada.

### Por quê?

Terrain é excelente para:

- relevo regional;
- drenagem;
- encostas;
- bacias;
- análise topográfica.

Mas é uma escolha ruim para dominar uma inspeção de casas numa área urbana relativamente plana.

---

# 7. Câmeras

## Topo

Uso:

- leitura cartográfica;
- polígonos;
- seleção;
- comparação territorial.

## 3D

Uso:

- centro operacional padrão;
- visão de conjunto;
- ocorrências e territórios.

## Baixo

Uso:

- leitura cinematográfica;
- corredores urbanos;
- inspeção visual.

## Micro

Uso:

- casas;
- pequenos prédios;
- quarteirões;
- inspeção de footprint;
- profundidade urbana.

---

# 8. Ferramentas operacionais

A v0.3.2 preserva as ferramentas da v0.3.

## 1. Inspector de prédio

Clique em uma edificação.

Mostra:

- identificador;
- altura;
- área de implantação;
- pavimentos estimados;
- classe;
- confiança;
- método de altura;
- fonte;
- coordenadas.

No modo OSM real, a ficha deixa explícito quando:

- o footprint é real;
- a altura veio da fonte;
- a altura precisou de padrão visual.

## 2. Territórios

- desenhar;
- finalizar;
- editar vértices;
- persistir localmente durante a demonstração.

## 3. Seleção espacial

Desenhe um polígono.

A aplicação seleciona edificações dentro da área.

No modo OSM real, utiliza os vector tiles atualmente carregados pelo viewport.

## 4. Timeline

- slider temporal;
- reprodução;
- atualização dos filtros de ocorrências.

## 5. Fiscalização

- selecione `Fiscalizar`;
- clique em uma edificação;
- cria uma vistoria local;
- conclua a fiscalização.

## 6. Medição

- distância;
- múltiplos segmentos;
- área aproximada.

## 7. Perfil altimétrico

Traça uma linha e consulta o DEM quando disponível.

## 8. Cruzamento territorial

Cruza:

- área;
- ocorrências;
- críticas;
- risco médio;
- edificações;
- altura média;
- fiscalizações;
- densidade.

## 9. Harpex AI

Controlador local por linguagem natural.

Exemplos:

```text
Analise o Centro
Selecione prédios do Centro
Mostre só críticas
Abra a linha do tempo
Inicie fiscalização
Perfil de elevação
Meça distância
Vista Micro
Mostre prédios
Oculte heatmap
```

---

# 9. HarpexMap

A aplicação expõe:

```javascript
window.HarpexMap
```

Exemplos:

```javascript
HarpexMap.showLayer('buildings')
HarpexMap.hideLayer('heatmap')
HarpexMap.analyzeTerritory('Centro')
HarpexMap.selectBuildingsInTerritory('Centro')
HarpexMap.startInspection()
HarpexMap.startMeasurement()
HarpexMap.startElevationProfile()
HarpexMap.openTimeline()
HarpexMap.setBuildingSource('real')
HarpexMap.setBuildingSource('fallback')
HarpexMap.getBuildingSource()
HarpexMap.command('vista micro')
```

Essa superfície deve ser usada no futuro pelo backend de tool calling da Harpex AI.

---

# 10. Dados: o que é real e o que não é

## Real

### Edificações em `OSM real`

- geometria/footprint: OpenStreetMap/OpenMapTiles;
- altura: pode ser real/derivada quando presente no tile;
- ausência de altura: padrão visual explicitamente sinalizado.

## Simulado

### Ocorrências

Continuam simuladas.

## Preview

### Fallback de edificações

A malha procedimental não é cadastro urbano real.

---

# 11. Performance

## Por que vector tiles?

Porque enviar todas as edificações de Parnaíba em um único GeoJSON não escala bem.

Com vector tiles:

```text
PostGIS/OSM
    ↓
vector tile
    ↓
viewport atual
    ↓
MapLibre
```

O navegador recebe apenas o que precisa.

### LOD

A aplicação usa níveis de detalhe:

```text
z < 13     contexto
z 13–15    volumes 3D
z 15+      footprints e bordas
z 16+      Micro 3D
```

---

# 12. Banco de dados de produção

A pasta `db/` contém uma proposta pronta para PostGIS.

## `001_geo_core.sql`

Inclui:

- municipalities;
- buildings;
- territories;
- incidents;
- inspections;
- índices GiST;
- proveniência;
- `MultiPolygon` para edificações.

## `002_vector_tiles.sql`

Inclui exemplo de função:

```sql
harpex_buildings_mvt(z, x, y, municipality_id)
```

baseada em:

```sql
ST_TileEnvelope
ST_AsMVTGeom
ST_AsMVT
```

---

# 13. Validação

Execute:

```bash
npm run validate
```

O validador verifica:

- versão;
- MapLibre ESM;
- vector source real;
- `source-layer: building`;
- `render_height`;
- seletor OSM/Preview;
- Micro camera;
- `window.HarpexMap`;
- atribuição;
- IDs duplicados;
- sintaxe JavaScript.

---

# 14. Hash do HTML

```bash
npm run hash
```

---

# 15. Segurança

O HTML não deve receber segredos.

Nunca coloque no frontend:

```text
SUPABASE_SERVICE_ROLE_KEY
OPENAI_API_KEY
DATABASE_URL com senha
JWT secret
credenciais administrativas
```

A Harpex AI real deve ficar:

```text
frontend
   ↓
backend autenticado
   ↓
agent/tool calling
   ↓
HarpexMap/API geoespacial
```

---

# 16. Troubleshooting rápido

## Ficou cinza ao aproximar

1. confirme **Terreno 3D = OFF**;
2. clique em **Micro**;
3. mantenha Satélite ON;
4. veja o status de **OSM real**;
5. se a fonte real estiver indisponível, teste **Preview**.

## Não aparecem prédios reais

- aproxime para zoom 13+;
- aguarde os tiles;
- confira indicador verde/vermelho;
- verifique rede/firewall para `tiles.openfreemap.org`.

## HTML direto apresenta bloqueios

Use:

```bash
npm run preview
```

---

# 17. Licenças e atribuição

Consulte:

```text
LICENSES_AND_ATTRIBUTION.md
```

A interface deixa a atribuição do MapLibre ativada.

---

# 18. Próxima arquitetura de produção

```text
                        HARPEX GEO
                            │
                 Next.js / Web App
                            │
                        MapLibre
                  ┌─────────┼─────────┐
                  │         │         │
              Vector     Satélite  Territórios
               Tiles                / Incidentes
                  │
               API Geo
                  │
               PostGIS
          ┌───────┼────────┐
          │       │        │
         OSM   Overture   Harpex
          │       │       ocorrências
          └── altura / proveniência

Harpex AI
    │
Tool Calling
    │
HarpexMap + APIs autenticadas
```

---

# 19. Critério de qualidade desta versão

A v0.3.2 não tenta resolver tudo fingindo que uma única fonte é perfeita.

Ela aplica três princípios:

1. **real quando existe**;
2. **estimado quando necessário, mas identificado**;
3. **preview somente quando explicitamente escolhido**.

Essa separação é especialmente importante para um produto destinado a gestão pública.
