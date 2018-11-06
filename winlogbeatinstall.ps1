Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Start-BitsTransfer -Source "https://elktools.blob.core.windows.net/tools/winlogbeat.zip" -Destination "C:\"
Add-Type -AssemblyName System.IO.Compression.FileSystem
function unzip {
param( [string]$ziparchive, [string]$extractpath )
[System.IO.Compression.ZipFile]::ExtractToDirectory( $ziparchive, $extractpath )
}
unzip "c:\winlogbeat.zip" "c:\"

Invoke-Expression -Command "C:\winlogbeat\install-service-winlogbeat.ps1"
Start-Service winlogbeat