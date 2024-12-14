function Get-PanGPACertificateString {
    param()

    $GetItemPropertyConfig = @{
        Path = 'HKCU:\Software\Palo Alto Networks\GlobalProtect\PanMSAgent'
        Name = "previousCertificate"
    } 
    Get-ItemProperty @GetItemPropertyConfig | Select-Object -ExpandProperty $GetItemPropertyConfig.Name
}