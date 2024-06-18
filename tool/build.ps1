

# カレントディレクトリを常にこのスクリプトがあるフォルダの一つ上にする。
Set-Location $(Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location "../"


# プロジェクト構造の設定
$projectRoot = Get-Location
$config = @{

    root = $projectRoot
    output = "$projectRoot/build"

    subproject = @(

        @{

            root = "$projectRoot/cui"
            output = "$projectRoot/cui/bin/Debug/net6.0-windows7.0/win-x64/publish"
            buildFunc = {dotnet publish}
        }

        @{

            root = "$projectRoot/gui"
            output = "$projectRoot/gui/build/windows/x64/runner/Release"
            buildFunc = {flutter build windows}
        }
    )
}


$ErrorActionPreference = $true
try
{
    echo "Output Path: ${config.output}"
    Remove-Item $config.output -Recurse -Force
    New-Item -ItemType "directory" -Path $config.output


    foreach ($sub in $config.subproject)
    {
        
        Set-Location $sub.root
        echo "Subproject: $(Get-Location)"
        

        # ビルド
        Invoke-Command $sub.buildFunc

        # 内容をコピー
        $src = $sub.output
        Copy-Item -Path "$src/*" -Destination $config.output -Recurse
    }

    Set-Location $config.root
}
catch
{
    $error[0] | Out-String | Write-Output
    pause
}