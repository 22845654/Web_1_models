@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Django - Web_1_models (port 8000)
if not exist .venv\Scripts\python.exe call ustanovka.bat
start "" cmd /c "timeout /t 4 >/dev/null & start http://127.0.0.1:8000/"
echo Site: http://127.0.0.1:8000/   (stop: Ctrl+C)
.venv\Scripts\python.exe manage.py runserver 8000
pause
