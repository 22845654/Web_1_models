@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Zagruzka proekta na GitHub
set "PATH=%PATH%;C:\Program Files\Git\cmd;C:\Program Files\GitHub CLI"
set LOG=github_log.txt
echo === START %DATE% %TIME% > %LOG%

where git >nul 2>nul
if errorlevel 1 (
  echo === Ustanavlivayu Git ...
  winget install --id Git.Git -e --silent --accept-source-agreements --accept-package-agreements
)
where gh >nul 2>nul
if errorlevel 1 (
  echo === Ustanavlivayu GitHub CLI ...
  winget install --id GitHub.cli -e --silent --accept-source-agreements --accept-package-agreements
)
git --version >> %LOG% 2>&1
gh --version >> %LOG% 2>&1

gh auth status >nul 2>nul
if errorlevel 1 (
  echo.
  echo ============================================================
  echo  Sejchas otkroetsya brauzer. Nazhmite Enter, vvedite kod,
  echo  kotoryj pokazan nizhe, i nazhmite Authorize.
  echo ============================================================
  gh auth login --hostname github.com --git-protocol https --web
)
gh auth setup-git >> %LOG% 2>&1
gh auth status >> %LOG% 2>&1

for /f "delims=" %%i in ('gh api user --jq .login') do set GHUSER=%%i
for /f "delims=" %%i in ('gh api user --jq .id') do set GHID=%%i
echo GHUSER=%GHUSER% >> %LOG%

if not exist .git (
  echo $ git init >> %LOG%
  git init >> %LOG% 2>&1
)
git config user.name "%GHUSER%"
git config user.email "%GHID%+%GHUSER%@users.noreply.github.com"

echo $ git add -A >> %LOG%
git add -A >> %LOG% 2>&1
echo $ git status >> %LOG%
git status >> %LOG% 2>&1
echo $ git commit -m "Первая версия приложения перенесена на github" >> %LOG%
git commit -m "Первая версия приложения перенесена на github" >> %LOG% 2>&1
git branch -M main

git remote get-url origin >nul 2>nul
if errorlevel 1 (
  echo $ gh repo create Web_1_models --public --source . --remote origin >> %LOG%
  gh repo create Web_1_models --public --source . --remote origin --description "Модели данных Django — Кумарбек Ернар, КВТ-23-9" >> %LOG% 2>&1
)
echo $ git push -u origin main >> %LOG%
git push -u origin main >> %LOG% 2>&1
echo === DONE >> %LOG%
type %LOG%
echo.
echo === Gotovo. Okno mozhno zakryt.
pause
