

$caller = Get-Location

# カレントディレクトリを常にこのスクリプトがあるフォルダの一つ上にする。
Set-Location $(Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location "../"


# プロジェクト構造を取得
$config = (./tool/project_config.ps1)


$ErrorActionPreference = $true
try
{
    echo "Artifact Path: ${config.artifact}"
    Remove-Item $config.artifact -Recurse -Force
    New-Item -ItemType "directory" -Path $config.artifact

    foreach ($sub in $config.subproject.values)
    {
        
        Set-Location $sub.root
        echo "Subproject: $(Get-Location)"
        
        # ビルド
        Invoke-Command $sub.buildFunc

        # 内容をコピー
        $src = $sub.artifact
        Copy-Item -Path "$src/*" -Destination $config.artifact -Recurse
    }

    Set-Location $caller
}
catch
{
    $error[0] | Out-String | Write-Output
    pause
}