@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Ustanovka Web_1_models
set BASE=C:\Users\kumal\AppData\Local\Programs\Python\Python314\python.exe
if not exist "%BASE%" set BASE=py
echo === START %DATE% %TIME% > setup_log.txt
if not exist .venv\Scripts\python.exe "%BASE%" -m venv .venv >> setup_log.txt 2>&1
.venv\Scripts\python.exe --version >> setup_log.txt 2>&1
.venv\Scripts\python.exe -m pip install --disable-pip-version-check -r requirements.txt >> setup_log.txt 2>&1
.venv\Scripts\python.exe manage.py migrate >> setup_log.txt 2>&1
.venv\Scripts\python.exe manage.py collectstatic --noinput >> setup_log.txt 2>&1
.venv\Scripts\python.exe manage.py check >> setup_log.txt 2>&1
echo === GIT >> setup_log.txt
where git >> setup_log.txt 2>&1
echo === DONE >> setup_log.txt
