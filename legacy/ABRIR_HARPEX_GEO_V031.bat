@echo off
setlocal
cd /d "%~dp0"
start "" http://127.0.0.1:8787/preview/harpex-geo-v03.1-micro3d.html
python -m http.server 8787
