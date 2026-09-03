# Performance

## Preview

O modo OSM real usa vector tiles, portanto o navegador carrega apenas os tiles necessários ao viewport.

O modo Preview usa GeoJSON embutido e deve ser considerado fallback, não arquitetura de escala.

## Princípios

1. Preferir vector tiles para edificações.
2. Evitar enviar uma cidade inteira em um único GeoJSON.
3. Usar minzoom nas extrusões.
4. Mostrar outlines apenas em zoom alto.
5. Manter terrain fora do micro-zoom.
6. Evitar múltiplas camadas de sombra em dispositivos fracos.

## Perfil recomendado

### Desktop moderno
- edifícios reais: ON
- satélite: ON
- heatmap: ON quando necessário
- terrain: OFF em micro 3D

### Mobile/iPad antigo
- reduzir pitch;
- usar visão Topo/3D, evitando Baixo por longos períodos;
- desligar heatmap quando houver queda de FPS;
- manter terrain OFF.
