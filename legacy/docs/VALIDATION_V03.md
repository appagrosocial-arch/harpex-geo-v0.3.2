# Validação — Harpex Geo v0.3

## Verificações realizadas

- JavaScript extraído do `<script type="module">`: `node --check` sem erro de sintaxe.
- HTML servido por `python -m http.server`: HTTP 200.
- Dados embutidos validados: 600 prédios, 84 ocorrências, 5 territórios iniciais.
- Teste geométrico independente sobre os dados embutidos:
  - Ilha Grande: 3 prédios / 9 ocorrências.
  - Bebedouro: 78 prédios / 15 ocorrências.
  - Centro: 468 prédios / 18 ocorrências.
  - Santa Luzia: 50 prédios / 9 ocorrências.
  - Nova Parnaíba: 0 prédios / 13 ocorrências na amostra atual.
- Presença verificada no bundle das 10 capacidades solicitadas: ficha 3D, desenho/edição, seleção poligonal, timeline, animação, fiscalização, medição, perfil de elevação, cruzamento territorial e Harpex AI/tool surface.
- Novas ocorrências recebem timestamp e participam da timeline.
- Territórios criados/editados e fiscalizações de demonstração têm persistência local protegida por `try/catch`.

## Validação que o ambiente atual não consegue concluir visualmente

O Chromium disponível neste ambiente não inicializa WebGL/ANGLE corretamente em modo headless. Portanto, não foi produzida uma screenshot falsa dizendo que o MapLibre renderizou aqui. A sintaxe, o servidor, os dados e a lógica foram validados; a renderização 3D precisa de um navegador com WebGL e acesso às fontes externas de tiles/MapLibre.

## Segurança da Harpex AI

A interface não executa JavaScript gerado pelo usuário. Comandos são traduzidos para um conjunto fechado de ações do mapa. Nenhuma chave de IA foi embutida no HTML.
