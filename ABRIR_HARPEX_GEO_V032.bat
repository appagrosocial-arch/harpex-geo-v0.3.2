@echo off
setlocal
cd /d "%~dp0"
where node >nul 2>nul
if %errorlevel%==0 (
  start "" http://127.0.0.1:8787/
  node scripts\serve.mjs
  exit /b
)
where python >nul 2>nul
if %errorlevel%==0 (
  start "" http://127.0.0.1:8787/
  python -m http.server 8787 --bind 127.0.0.1
  exit /b
)
echo Instale Node.js 20+ ou Python 3 para iniciar o servidor local.
pause
