import { readFile, writeFile, unlink } from 'node:fs/promises';
import { spawnSync } from 'node:child_process';
import { tmpdir } from 'node:os';
import { join } from 'node:path';

const htmlPath = new URL('../preview/harpex-geo-v03.2-real3d.html', import.meta.url);
const html = await readFile(htmlPath, 'utf8');
const checks = [
  ['versão v0.3.2', html.includes('v0.3.2')],
  ['MapLibre 6.7 ESM', html.includes('maplibre-gl@6.7.0/dist/maplibre-gl.mjs')],
  ['OpenFreeMap real vector source', html.includes("url:'https://tiles.openfreemap.org/planet'")],
  ['source-layer building', html.includes("'source-layer':'building'")],
  ['render_height', html.includes("render_height")],
  ['modo OSM real', html.includes('data-building-mode="real"')],
  ['fallback explícito', html.includes('data-building-mode="fallback"')],
  ['micro câmera', html.includes('data-cam="micro"')],
  ['terrain desligado no micro 3D', html.includes('syncCloseZoom3D')],
  ['HarpexMap', html.includes('window.HarpexMap=')],
  ['atribuição OSM/OpenFreeMap', html.includes('OpenFreeMap © OpenMapTiles')]
];

const ids = [...html.matchAll(/\sid="([^"]+)"/g)].map(m => m[1]);
const duplicates = ids.filter((id, i) => ids.indexOf(id) !== i);
checks.push(['IDs HTML únicos', duplicates.length === 0]);

const moduleMatch = html.match(/<script type="module">\n([\s\S]*)\n<\/script>/);
if (!moduleMatch) checks.push(['script module encontrado', false]);
else {
  const tmp = join(tmpdir(), `harpex-v032-${process.pid}.mjs`);
  await writeFile(tmp, moduleMatch[1], 'utf8');
  const syntax = spawnSync(process.execPath, ['--check', tmp], { encoding: 'utf8' });
  await unlink(tmp).catch(() => {});
  checks.push(['JavaScript sintaticamente válido', syntax.status === 0]);
  if (syntax.status !== 0) console.error(syntax.stderr);
}

let failures = 0;
for (const [name, ok] of checks) {
  console.log(`${ok ? 'OK ' : 'FAIL'}  ${name}`);
  if (!ok) failures++;
}
console.log(`\n${checks.length - failures}/${checks.length} verificações aprovadas.`);
if (duplicates.length) console.error('IDs duplicados:', duplicates.join(', '));
process.exitCode = failures ? 1 : 0;
