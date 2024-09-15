@REM 第3引数が空欄ならHEADとの差分を取得
if "%3" equ "" (
  set param1=HEAD
  set param2=%2
) else (
  set param1=%2
  set param2=%3
)

@REM 変数定義
set FOLDER=%1_差分ファイル\
set LIST=%FOLDER%ChangeFileList.txt
set BASE_FILE=%FOLDER%diff_base.zip
set NEW_FILE=%FOLDER%diff_change.zip

@REM フォルダ作成
if not exist "%FOLDER%" (
  mkdir %FOLDER%
)

@REM @REM @REM チェンジリストの作成
echo %date% %time% > %LIST%
echo ベースのバージョン=%param1% >> %LIST%
echo 変更後のバージョン=%param2% >> %LIST%
echo. >> %LIST%
echo M=変更、A=追加、C=コピー、R=リネーム、D=削除 >> %LIST%
echo ステータスがMとなっているファイルのみを差分ファイルとして抽出します>> %LIST%
echo. >> %LIST%
git diff --name-status %param2% %param1% >> %LIST%

setlocal enabledelayedexpansion

@REM @REM @REM Mのみのチェンジリストの作成
set diff=
for /f "usebackq" %%i in (`git diff --name-only %param2% %param1% --diff-filter=M`) do (
  set diff=!diff! "%%i"
)

@REM @REM @REM Mのみのチェンジリストを元にファイルを抽出して圧縮
git archive --format=zip %param2% %diff% --output=%BASE_FILE%
git archive --format=zip %param1% %diff% --output=%NEW_FILE%

@REM ベースのリビジョンのメモを作成
@REM set revision= 
@REM for /f "usebackq delims=" %%i in (`git log %3 -n 1`) do (
@REM   set revision=!revision! "%%i"
@REM )
@REM echo %revision% > %FOLDER%\text.txt

@REM $OutputEncoding = [System.Text.Encoding]::GetEncoding('utf-8')

endlocal