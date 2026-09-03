#!/bin/sh
cd "$(dirname "$0")" || exit 1
if command -v node >/dev/null 2>&1; then
  (sleep 1; open http://127.0.0.1:8787/) &
  exec node scripts/serve.mjs
fi
python3 -m http.server 8787 --bind 127.0.0.1
