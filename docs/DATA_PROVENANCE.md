# Proveniência e honestidade de dados

A Harpex deve tratar procedência como parte do dado, não como nota de rodapé.

## Classes recomendadas

- **OFICIAL** — fornecido por órgão público responsável.
- **OSM_REAL** — geometria real de OpenStreetMap/OpenMapTiles.
- **DERIVADO** — calculado a partir de dados reais.
- **ESTIMADO** — valor inferido com método explícito.
- **DECLARADO** — informado por cidadão/operador.
- **SIMULADO** — gerado apenas para demonstração/teste.
- **PREVIEW** — geometria visual de fallback.

## Edificações desta versão

### Modo OSM real

- footprint: real OSM;
- altura: `render_height` quando fornecida pelo schema OpenMapTiles;
- sem altura: 5,8 m de altura visual padrão;
- o inspector informa a origem.

### Modo Preview

- volumes locais procedimentais;
- não representam edificações oficiais;
- servem para validar UX, seleção e performance.

## Ocorrências

As ocorrências do HTML continuam SIMULADAS. O fato de a edificação ser real não torna a ocorrência real.
