

# カレントディレクトリを常にこのスクリプトがあるフォルダの一つ上にする。
Set-Location $(Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location "../"


# プロジェクト構造の設定
$projectRoot = Get-Location
$config = @{

    root = $projectRoot

    subproject = @(

        @{

            root = "$projectRoot/cui"
            setupFunc = {dotnet restore}
        }

        @{

            root = "$projectRoot/gui"
            setupFunc = {flutter pub get}
        }
    )
}



$ErrorActionPreference = $true
try
{
    foreach ($sub in $config.subproject)
    {
        Set-Location $sub.root

        # セットアップ
        Invoke-Command $sub.setupFunc
    }

    Set-Location $config.root
}
catch
{
    $error[0] | Out-String | Write-Output
    pause
}