New-Item -Path c:\test  -ItemType directory
#download executable, this is the small online installer
$source = "http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-windows-x64.exe"
$destination = "c:\test\jdk-8u191-windows-x64.exe"
$client = New-Object System.Net.WebClient
$cookie = "oraclelicense=accept-securebackup-cookie"
$client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $cookie)
$client.DownloadFile($source, $destination)

#install silently
Start-Process -FilePath "c:\test\jdk-8u191-windows-x64.exe" -ArgumentList '/s INSTALL_SILENT=Enable AUTO_UPDATE=Enable SPONSORS=Disable REMOVEOUTOFDATEJRES=1'

#Sleep till installation completed
Start-Sleep -Seconds 180

# Set JAVA_HOME
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk1.8.0_191\bin")