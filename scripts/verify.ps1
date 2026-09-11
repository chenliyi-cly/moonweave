param(
  [ValidateSet('wasm-gc','wasm','js','native')][string]$Target='wasm-gc',
  [string]$MoonHome,
  [string]$Python='python'
)
$ErrorActionPreference='Stop'
$oldPath=$env:PATH
$oldHome=$env:MOON_HOME
Push-Location -LiteralPath (Split-Path -Parent $PSScriptRoot)
try {
  if ($MoonHome) {
    $resolved=(Resolve-Path -LiteralPath $MoonHome).Path
    if (-not (Test-Path -LiteralPath (Join-Path $resolved 'bin\moon.exe'))) {throw 'MoonHome does not contain bin/moon.exe'}
    $env:MOON_HOME=$resolved
    $env:PATH="$(Join-Path $resolved 'bin');$oldPath"
  }
  & moon version --all
  if ($LASTEXITCODE -ne 0) {throw 'MoonBit toolchain unavailable'}
  & $Python (Join-Path $PSScriptRoot 'verify.py') --target $Target
  if ($LASTEXITCODE -ne 0) {throw 'MoonWeave verification failed'}
} finally {
  $env:PATH=$oldPath
  $env:MOON_HOME=$oldHome
  Pop-Location
}
