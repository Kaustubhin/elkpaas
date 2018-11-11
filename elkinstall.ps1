Set-ExecutionPolicy unrestricted -Force
Set-NetFirewallProfile -Name Domain -Enabled False
Set-NetFirewallProfile -Name Public -Enabled False
Set-NetFirewallProfile -Name Private -Enabled False


<##Create dir to save java
New-Item -Path c:\tools  -ItemType directory
#Download Java executable
$source = "http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-windows-x64.exe"
$destination = "c:\tools\jdk-8u191-windows-x64.exe"
$client = New-Object System.Net.WebClient
$cookie = "oraclelicense=accept-securebackup-cookie"
$client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $cookie)
$client.DownloadFile($source, $destination)

#install silently
Start-Process -FilePath "c:\tools\jdk-8u191-windows-x64.exe" -ArgumentList '/s INSTALL_SILENT=Enable AUTO_UPDATE=Enable SPONSORS=Disable REMOVEOUTOFDATEJRES=1'

#Sleep till installation completed
Start-Sleep -Seconds 180

# Set JAVA_HOME
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk1.8.0_191")
[Environment]::SetEnvironmentVariable("PATH", "%JAVA_HOME%\bin;%PATH%")
#setx JAVA_HOME "C:\Program Files\Java\jdk1.8.0_191"
#setx PATH "%JAVA_HOME%\bin;%PATH%"#>

#Create folder and download and extract installables 
New-Item -Path c:\elk -ItemType directory
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Start-BitsTransfer -Source "https://elktools.blob.core.windows.net/tools/elk.zip" -Destination "C:\"
Add-Type -AssemblyName System.IO.Compression.FileSystem
function unzip {
param( [string]$ziparchive, [string]$extractpath )
[System.IO.Compression.ZipFile]::ExtractToDirectory( $ziparchive, $extractpath )
}
unzip "c:\elk.zip" "c:\elk"


#Install ELK-Stack silently
<#Invoke-Expression -command "c:\elk\elk\elasticsearch\bin\elasticsearch-service.bat install"
Invoke-Expression -command "c:\elk\elk\elasticsearch\bin\elasticsearch-service.bat start"
Start-sleep 180
Invoke-Expression -command "c:\elk\elk\nssm\win64\NSSM install logstash c:\elk\elk\logstash\bin\Logstash.bat"
Invoke-Expression -command "c:\elk\elk\nssm\win64\NSSM set logstash AppParameters agent --config C:\elk\elk\logstash\config\logstash-sample.conf"
Invoke-Expression -command "c:\elk\elk\nssm\win64\NSSM set logstash AppDirectory C:\elk\elk\logstash"
Invoke-Expression -command "c:\elk\elk\nssm\win64\NSSM set logstash AppEnvironmentExtra 'Java_HOME=C:\Program Files\Java\jdk1.8.0_191'"
Invoke-Expression -command "c:\elk\elk\nssm\win64\NSSM set logstash AppStdout C:\elk\elk\logstash\logs\stdout.log"
Invoke-Expression -command "c:\elk\elk\nssm\win64\NSSM set logstash AppStderr C:\elk\elk\logstash\logs\stderr.log" 
Invoke-Expression -command "c:\elk\elk\nssm\win64\nssm start logstash"
Start-Sleep 180#>
Invoke-Expression -command "c:\elk\elk\nssm\win64\NSSM install kibana c:\elk\elk\kibana\bin\kibana.bat"
Invoke-Expression -command "c:\elk\elk\nssm\win64\NSSM start kibana"
Start-Sleep 180
Write-Host "Elk-Stack Installed successfully!!"
