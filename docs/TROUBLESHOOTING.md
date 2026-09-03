# Troubleshooting

## “Map data not yet available” / bloco cinza ao aproximar

A v0.3.2 reduz esse problema desligando terrain no micro-zoom.

Se ainda ocorrer:

1. desligue **Terreno 3D**;
2. mantenha **Satélite** ligado;
3. use a câmera **Micro**;
4. confira se `tiles.openfreemap.org` está acessível;
5. alterne temporariamente para **Preview** para distinguir falha de rede de falha do MapLibre.

## Não aparecem casas reais

- aguarde os vector tiles carregarem;
- aproxime para zoom 13+;
- observe o indicador `EDIFICAÇÕES` no canto superior direito;
- se ficar vermelho, a fonte real falhou;
- use **Preview** somente como fallback visual.

## WebGL não inicia

Atualize o navegador e driver de vídeo. Confirme que aceleração por hardware está habilitada.

## O satélite não carrega

A camada de imagem vem de serviço externo. Teste a rede/firewall. A aplicação continua podendo renderizar overlays sem satélite.

## O terreno não carrega

O DEM é externo e opcional. Para operação urbana de bairro, deixe desligado.

## Abri o HTML direto e algo foi bloqueado

Use o servidor local:

```bash
npm run preview
```

ou:

```bash
python -m http.server 8787
```
