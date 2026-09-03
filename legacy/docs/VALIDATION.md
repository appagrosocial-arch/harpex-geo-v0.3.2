# Validação executada nesta entrega

Data: 2026-09-02

## Passou

- `node --check` em todos os scripts `.mjs`.
- `python3 -m py_compile` em todos os scripts Python.
- `package.json` parseado como JSON válido.
- `public/data/predios-amostra.geojson`: FeatureCollection válida com 600 feições Polygon/MultiPolygon.
- busca estática sem `nominatim.openstreetmap.org`, `Math.random()`, `BASE_LAYER_IDS` ou `select using (true)` na v0.2.
- preview desktop gerado em 1600×1000.
- preview mobile gerado em 430×932.
- TypeScript foi parseado pelo compilador global; os diagnósticos restantes no ambiente de entrega são de módulos/tipos externos ausentes porque `node_modules` não pôde ser instalado.

## Limitação do ambiente

O ambiente de geração não conseguiu resolver `registry.npmjs.org` por DNS. Por isso não foi possível executar `npm install`, gerar um `package-lock.json` confiável, `next build`, Vitest, Playwright ou ESLint com as dependências reais.

Não foi fabricado um lockfile. Em um ambiente com internet:

```bash
cp .env.example .env
npm install
npm run typecheck
npm run lint
npm test
npm run build
npm run test:e2e
```

Depois do primeiro `npm install`, versione o `package-lock.json` e troque o passo de CI de `npm install` para `npm ci`.

## Banco

As migrations não foram aplicadas contra um Supabase real nesta sessão, pois nenhum `DATABASE_URL`/credencial foi fornecido. Antes de produção, rode os testes RLS descritos em `SECURITY.md` com pelo menos dois municípios.

## Correção do preview

O primeiro `preview.html` usava uma malha SVG apenas para composição visual e não era uma representação geográfica de Parnaíba. Ele foi substituído por `preview/preview-live.html`, que usa um mapa real do OpenStreetMap centrado em Parnaíba. A aplicação em `components/MapCanvas.tsx` continua usando MapLibre + tiles OSM; o preview live existe apenas para permitir inspeção rápida sem executar o projeto Next.js.

## Validação v0.2.1 — preview MapLibre

- `preview/preview-maplibre.html` usa `new maplibregl.Map()` diretamente.
- Não contém `<iframe>` nem `<svg>` simulando cartografia.
- JavaScript embutido passou em `node --check` após remoção exclusiva da linha de import remoto.
- 600 prédios de validação são adicionados por camada `fill-extrusion`.
- Territórios são adicionados como GeoJSON (`fill`, `line` e `symbol`).
- Ocorrências simuladas possuem cluster e heatmap MapLibre.
- Terreno usa source `raster-dem` e `setTerrain()` quando a fonte pública está disponível.
- Atribuição do OpenStreetMap permanece visível.
- `scripts/preview-server.mjs` passou em `node --check` e respondeu HTTP 200 para o preview.
- O runtime deste ambiente não resolve DNS externo (`unpkg.com` / `tile.openstreetmap.org`), portanto não foi gerada screenshot fingindo que os tiles foram carregados. Em um navegador com internet, o preview baixa MapLibre e os tiles normalmente.
