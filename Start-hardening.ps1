configuration Setup_Config  
{
param
(
# Target nodes to apply the configuration
[string[]]$NodeName = 'localhost'
)
# Import the module that defines custom resources
Import-DscResource -ModuleName xPSDesiredStateConfiguration
Import-DscResource -ModuleName xRemoteFile

Node $NodeName

Registry 'DisableRunAs' {
    Ensure    = 'Present'
    Key       = 'HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WinRM\Service'
    ValueName = 'DisableRunAs'
    ValueType = 'DWord'
    ValueData = '1'
}
WindowsFeature 'Telnet-Client' {
    Name   = 'Telnet-Client'
    Ensure = 'Present'
}
Registry 'AdmPwdEnabled' {
    Ensure    = 'Present'
    Key       = 'HKEY_LOCAL_MACHINE\Software\Policies\Microsoft Services\AdmPwd'
    ValueName = 'AdmPwdEnabled'
    ValueType = 'DWord'
    ValueData = '1'
}

xRemoteFile javaInstaller {
    DestinationPath = (Join-Path $localDscFileDir "Java\jreInstaller.exe")
    Uri = "http://javadl.oracle.com/webapps/download/AutoDL?BundleId=211999"
}
Package java8
{
    Ensure = 'Present'
    Name = 'Java 8'
    Path = (Join-Path $localDscFileDir "Java\jreInstaller.exe")
    Arguments = '/s REBOOT=0 SPONSORS=0 REMOVEOUTOFDATEJRES=1 INSTALL_SILENT=1 AUTO_UPDATE=0 EULA=0 /l*v "C:\DscFiles\Java\jreInstaller.exe.log"' #From https://powershell.org/forums/topic/issue-installing-java-32-bit-using-package-resource/#post-39206
    ProductId = '26A24AE4-039D-4CA4-87B4-2F64180101F0'
    DependsOn = @("[xRemoteFile]javaInstaller")         
}