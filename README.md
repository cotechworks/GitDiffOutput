# GitDiffOutput
## 概要
指定した2つのコミット間の差分ファイルを抽出するバッチファイルです。
WinMerge等で差分を比較しやすいよう、古いコミットと新しいコミットをzip圧縮して出力します。

差分ファイル抽出に使用したチェンジリストも併せて出力します。
比較ソフトで使用する関係で、「追加」「削除」「コピー」のステータスをもつファイルは出力されません。
目当てのファイルが出力されない場合はチェンジリストでステータスを確認してください。

## 引数
| 引数 | 機能 | 
| -- | -- | 
| 第1引数 | 差分ファイルの出力先 | 
| 第2引数 | 古いコミットのハッシュ | 
| 第3引数(省略可) | 新しいコミットのハッシュ | 

第1引数に指定したパスに「*リポジトリ名*_差分ファイル」という名前のフォルダを作成して出力します。
第3引数を省略した場合は、第2引数で指定したコミットとHEADの差分ファイルを出力します。
