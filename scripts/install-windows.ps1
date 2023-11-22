$TOFU_VERSION="1.6.0-alpha5"
$TARGET=Join-Path $env:LOCALAPPDATA OpenTofu $TOFU_VERSION
if (-not (Test-Path $TARGET)) {
  New-Item -ItemType Directory -Path $TARGET
}
Push-Location $TARGET
$TOFU_PATH=Join-Path $TARGET tofu.exe
if (Test-Path $TOFU_PATH) {
    $env:TOFU = $TOFU_PATH
    Set-Location $PSScriptRoot
    return
}
Invoke-WebRequest -Uri "https://github.com/opentofu/opentofu/releases/download/v${TOFU_VERSION}/tofu_${TOFU_VERSION}_windows_amd64.zip" -OutFile "tofu_${TOFU_VERSION}_windows_amd64.zip"
Expand-Archive "tofu_${TOFU_VERSION}_windows_amd64.zip" -DestinationPath $TARGET
$env:TOFU = $TOFU_PATH
Remove-Item "tofu_${TOFU_VERSION}_windows_amd64.zip"
Pop-Location
echo "OpenTofu is now available at ${TOFU_PATH}. Please add it to your path for easier access."

Set-Location $PSScriptRoot