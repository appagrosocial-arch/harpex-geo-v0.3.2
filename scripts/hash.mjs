import { createHash } from 'node:crypto';
import { createReadStream } from 'node:fs';
import { fileURLToPath } from 'node:url';
const path = fileURLToPath(new URL('../preview/harpex-geo-v03.2-real3d.html', import.meta.url));
const hash = createHash('sha256');
createReadStream(path).on('data', d => hash.update(d)).on('end', () => console.log(hash.digest('hex')));
