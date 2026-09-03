# Harpex Geo v0.3 — Centro Operacional Urbano 3D

Esta versão transforma o preview MapLibre em um laboratório geoespacial integrado. Os dados de prédios e ocorrências do HTML continuam marcados como **amostra/simulação**; as ferramentas são funcionais sobre os dados carregados.

## Ferramentas implementadas

1. **Ficha 3D de prédio** — clique em uma edificação para abrir ID, altura, área de implantação, pavimentos estimados, classe, fonte, método e coordenadas.
2. **Desenho de territórios** — ative `Território`, clique nos vértices e finalize em `Concluir` ou duplo clique.
3. **Edição de territórios** — ative `Editar`, clique no território e arraste os marcadores dos vértices. Territórios criados/editados são preservados no `localStorage` da demonstração.
4. **Seleção de prédios por polígono** — desenhe uma área; a engine seleciona os footprints cujo centróide cai dentro do polígono, realça-os em 3D e calcula quantidade, área total e altura média.
5. **Linha do tempo** — slider temporal filtra as ocorrências simuladas por data, combinado com o filtro de prioridade/tipo.
6. **Animação temporal** — botão Play reproduz a janela de 14 dias e faz as ocorrências surgirem progressivamente.
7. **Fiscalização** — ative `Fiscalizar` e clique em um prédio. Uma vistoria local é criada, exibida no mapa e pode ser marcada como concluída.
8. **Medição de distância e área** — marque pontos e finalize. Distância é calculada por Haversine; com 3+ pontos também é estimada a área.
9. **Perfil de elevação** — trace uma linha. O HTML amostra o trajeto e consulta `map.queryTerrainElevation()`. Se o DEM não estiver disponível, a interface informa isso em vez de inventar altitudes.
10. **Cruzamento territorial** — clique em um território para cruzar área, ocorrências, críticas, risco médio, prédios, altura média e fiscalizações.
11. **Harpex AI — controlador local** — comandos em português controlam filtros, câmera, territórios, seleção, fiscalização, medição, perfil, timeline e análise. A interface expõe as mesmas ações em `window.HarpexMap` para futura conexão com um modelo via tool calling.

## Comandos de Harpex AI para testar

- `Analise o Centro`
- `Selecione os prédios do Centro`
- `Mostre só ocorrências críticas`
- `Mostre alagamentos críticos`
- `Abra a linha do tempo`
- `Reproduza a linha do tempo`
- `Inicie fiscalização`
- `Perfil de elevação`
- `Meça distância`
- `Desenhe um novo território`
- `Edite território`
- `Abra o prédio amostra_12`
- `Oculte heatmap`
- `Mostre prédios`
- `Vista 3D`
- `Topo`
- `Zoom 15`
- `Limpar`

## API de automação do mapa

A página expõe `window.HarpexMap` com ações como:

- `showLayer(id)` / `hideLayer(id)`
- `flyTo(center, zoom)`
- `inspectBuilding(id)`
- `startTerritoryDrawing()`
- `editTerritory()`
- `selectBuildings()`
- `selectBuildingsInTerritory(name)`
- `analyzeTerritory(name)`
- `startInspection()`
- `startMeasurement()`
- `startElevationProfile()`
- `openTimeline()` / `playTimeline()` / `setTimeline(value)`
- `command(text)`
- `clearAnalysis()`
- `getState()`

## Limites deliberados

- O HTML não contém chave de API de IA. Isso evita expor segredos no navegador. O controlador local valida o fluxo de linguagem natural e a superfície de tools; a IA generativa deve ser conectada por backend.
- Prédios/alturas e ocorrências incluídos são dados demonstrativos, não registros oficiais de Parnaíba.
- Medições são exploratórias; levantamento legal/topográfico exige fonte oficial adequada.
