

# カレントディレクトリを常にこのスクリプトがあるフォルダの一つ上にする。
Set-Location $(Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location "../"


$files = @(

    "build",
    "cui/bin",
    "cui/obj",
    "gui/.dart_tool",
    "gui/build",
    "gui/gui.iml"
)




$ErrorActionPreference = $true
try
{
    foreach ($file in $files)
    {
        if(Test-Path $file)
        {
            Remove-Item -Path $file -Recurse -Force
        }
    }
}
catch
{
    $error[0] | Out-String | Write-Output
    pause
}