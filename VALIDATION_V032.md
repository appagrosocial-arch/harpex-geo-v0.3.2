# Validação — Harpex Geo v0.3.2

Data da validação: 2026-09-03

## Resultado automatizado

Comando:

```bash
npm run validate
```

Resultado:

```text
OK   versão v0.3.2
OK   MapLibre 6.7 ESM
OK   OpenFreeMap real vector source
OK   source-layer building
OK   render_height
OK   modo OSM real
OK   fallback explícito
OK   micro câmera
OK   terrain desligado no micro 3D
OK   HarpexMap
OK   atribuição OSM/OpenFreeMap
OK   IDs HTML únicos
OK   JavaScript sintaticamente válido

13/13 verificações aprovadas.
```

## Servidor local

O servidor Node foi iniciado e validado em:

```text
http://127.0.0.1:8787/
```

Resposta local:

```text
HTTP/1.1 200 OK
Content-Type: text/html; charset=utf-8
Cache-Control: no-store
X-Content-Type-Options: nosniff
Referrer-Policy: strict-origin-when-cross-origin
```

## Hash do HTML principal

```text
1aec173440a5fbb40ce960af0f9be721c7b7a5c75753735584083c49d0a64c97
```

## O que não pôde ser validado neste ambiente

O ambiente de empacotamento não possui resolução DNS externa funcional para os hosts de tiles. Por isso, não foi possível confirmar localmente o conteúdo visual retornado por:

- OpenFreeMap/OpenMapTiles;
- Esri imagery;
- Mapterhorn DEM;
- UNPKG.

Isso não foi mascarado com screenshot falsa. A aplicação inclui indicadores de status e fallback explícito para separar falha de rede de falha da engine.

## Validação recomendada em máquina conectada

1. executar `npm run preview`;
2. abrir `http://127.0.0.1:8787/`;
3. aguardar indicador **OSM real** ficar verde;
4. clicar em **Micro**;
5. aproximar para z16–18;
6. clicar em casas/prédios;
7. confirmar inspector;
8. alternar `OSM real` ↔ `Preview`;
9. confirmar que terrain não cria bloco cinza no micro-zoom;
10. testar seleção, fiscalização e cruzamento territorial.
