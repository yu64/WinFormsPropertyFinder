


$caller = Get-Location

# カレントディレクトリを常にこのスクリプトがあるフォルダの一つ上にする。
Set-Location $(Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location "../"


# プロジェクト構造を取得
$config = (./tool/project_config.ps1)



$ErrorActionPreference = $true
try
{
    Set-Location $config.subproject.gui.root
    Invoke-Command $config.subproject.gui.watchFunc

    Set-Location $caller
}
catch
{
    $error[0] | Out-String | Write-Output
    pause
}