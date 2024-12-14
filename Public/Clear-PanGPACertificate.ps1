function Clear-PanGPACertificate {
    $ItemPropertyConfig = @{
        Path = 'HKCU:\Software\Palo Alto Networks\GlobalProtect\PanMSAgent'
        Name = "previousCertificate"
    }
    Remove-ItemProperty @ItemPropertyConfig
}