

# プロジェクト構造の定義
$scriptDir = $(Split-Path -Parent $MyInvocation.MyCommand.Path)
$projectRoot = "$scriptDir/.."
@{

    root = $projectRoot
    output = "$projectRoot/build"

    # 成果物が生成される場所
    artifact = "$projectRoot/build"

    subproject = @(

        @{

            root = "$projectRoot/cui"
            output = "$projectRoot/cui/bin"
            artifact = "$projectRoot/cui/bin/Debug/net6.0-windows7.0/win-x64/publish"
            setupFunc = {dotnet restore}
            buildFunc = {dotnet publish}
            cleanFunc = {dotnet clean}
        }

        @{

            root = "$projectRoot/gui"
            output = "$projectRoot/gui/build"
            artifact = "$projectRoot/gui/build/windows/x64/runner/Release"
            setupFunc = {flutter pub get}
            buildFunc = {flutter build windows}
            cleanFunc = {flutter clean}
        }
    )
}