Configuration elkhardening {
param
    (
    # Target nodes to apply the configuration
    [string[]]$NodeName = 'localhost'
    )
# Import the module that defines custom resources
Import-DscResource -ModuleName PSDesiredStateConfiguration

Node $NodeName
{
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

  }
}
