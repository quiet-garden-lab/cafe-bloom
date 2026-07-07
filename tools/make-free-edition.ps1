# CafeBloom 無料版ファイル生成スクリプト
# 使い方: このフォルダで右クリック→「PowerShellで実行」か、
#         PowerShellで  .\tools\make-free-edition.ps1  を実行
# やること: 本体HTMLの EDITION を "free" に差し替えた
#           「CafeBloom_無料版.html」を作るだけ。本体は触らない。

$root = Split-Path -Parent $PSScriptRoot
$source = Join-Path $root "Cafe Bloom - 花帖喫茶.html"
$output = Join-Path $root "CafeBloom_無料版.html"

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$html = [System.IO.File]::ReadAllText($source, $utf8NoBom)

$marker = 'const EDITION = "full";'
$replacement = 'const EDITION = "free";'

if (-not $html.Contains($marker)) {
  Write-Host "エラー: 本体HTMLに $marker が見つからへん。EDITIONの行が変わってないか確認してな。" -ForegroundColor Red
  exit 1
}

$html = $html.Replace($marker, $replacement)
[System.IO.File]::WriteAllText($output, $html, $utf8NoBom)

Write-Host "できた: $output" -ForegroundColor Green
Write-Host "このファイルひとつで無料版として配布できる（0円配布用）。"
