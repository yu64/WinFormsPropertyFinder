

$caller = Get-Location

# カレントディレクトリを常にこのスクリプトがあるフォルダの一つ上にする。
Set-Location $(Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location "../"


# プロジェクト構造を取得
$config = (./tool/project_config.ps1)




$ErrorActionPreference = $true
try
{
    Remove-Item $config.output -Recurse -Force

    foreach ($sub in $config.subproject.values)
    {
        Set-Location $sub.root
        echo "Subproject: $(Get-Location)"

        Invoke-Command $sub.cleanFunc
    }

    Set-Location $caller
}
catch
{
    $error[0] | Out-String | Write-Output
    pause
}