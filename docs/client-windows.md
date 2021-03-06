# Windows client manual setup

## Automatic installation

To install automatically, use the generated user Powershell script.

1. Open Powershell as Administrator.
2. Run the following command:

```
Set-ExecutionPolicy Unrestricted -Scope Process
```

3. Then Run the following command on the same window:

```
powershell -ExecutionPolicy ByPass -File C:\path\to\windows_USER.ps1
```

## Manual installation

1. Copy the CA certificate (`cacert.pem`) and user certificate (`USER.p12`) to the client computer
2. Open PowerShell as Administrator. Navigate to your copied files.
3. If you haven't already, you will need to change the Execution Policy to allow unsigned scripts to run.

```powershell
Set-ExecutionPolicy Unrestricted -Scope CurrentUser
```

4. In the same window, run the necessary commands to install the certificates and create the VPN configuration. Note the lines at the top defining the VPN address, USER.p12 file location, and CA certificate location - change those lines to the IP address of your Algo server and the location you saved those two files. Also note that it will prompt for the "User p12 password", which is printed at the end of a successful Algo deployment.

If you have more than one account on your Windows 10 machine (e.g. one with administrator privileges and one without) and would like to have the VPN connection available to all users, then insert the line `AllUserConnection = $true` after `$EncryptionLevel = "Required"`.

```powershell
$VpnServerAddress = "1.2.3.4"
$UserP12Path = "$Home\Downloads\USER.p12"
$CaCertPath = "$Home\Downloads\cacert.pem"
$VpnName = "Algo VPN $VpnServerAddress IKEv2"
$p12Pass = Read-Host -AsSecureString -Prompt "User p12 password"

Import-PfxCertificate -FilePath $UserP12Path -CertStoreLocation Cert:\LocalMachine\My -Password $p12Pass
Import-Certificate -FilePath $CaCertPath -CertStoreLocation Cert:\LocalMachine\Root

$addVpnParams = @{
    Name = $VpnName
    ServerAddress = $VpnServerAddress
    TunnelType = "IKEv2"
    AuthenticationMethod = "MachineCertificate"
    EncryptionLevel = "Required"
}
Add-VpnConnection @addVpnParams

$setVpnParams = @{
    ConnectionName = $VpnName
    AuthenticationTransformConstants = "GCMAES256"
    CipherTransformConstants = "GCMAES256"
    EncryptionMethod = "AES256"
    IntegrityCheckMethod = "SHA384"
    DHGroup = "ECP384"
    PfsGroup = "ECP384"
    Force = $true
}
Set-VpnConnectionIPsecConfiguration @setVpnParams

```

5. After you execute the user script, set the Execution Policy back before you close the PowerShell window.

```powershell
Set-ExecutionPolicy Restricted -Scope CurrentUser
```

Your VPN is now installed and ready to use.
