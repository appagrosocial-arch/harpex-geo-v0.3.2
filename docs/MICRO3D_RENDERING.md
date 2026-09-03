# Micro 3D — casas e pequenos prédios

## Problema resolvido

No preview anterior, a aproximação podia produzir uma grande superfície cinza/sem leitura de edificações. Isso ocorria porque terrain/DEM e raster remoto tinham prioridade visual justamente no nível em que o operador queria observar casas.

## Estratégia da v0.3.2

### LOD por zoom

- z < 13: contexto urbano/regional;
- z 13–15: extrusão de edificações;
- z 15+: contorno fino de footprints;
- z 16+: micro 3D com profundidade reforçada.

### Terrain

O terrain começa desligado. Quando ativado manualmente:

- funciona em visão regional;
- é retirado automaticamente acima de ~z15.15.

Isso reduz artefatos de DEM em close urbano.

### Profundidade visual

A altura exibida recebe fator pequeno de visualização conforme o zoom. O objetivo não é falsificar a altura, mas tornar casas de 4–7 m perceptíveis em uma câmera oblíqua.

O valor original/derivado continua separado no inspector.

### Iluminação

Foi configurada luz global do MapLibre para aumentar contraste entre fachadas e topos de extrusões. Também foi adicionado sky/fog discreto para cenas inclinadas.
