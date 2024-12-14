function Set-PanGPACertificate {
    param(
       [Parameter(Position=1)]        
       [System.Security.Cryptography.X509Certificates.X509Certificate2] $Certificate
   )

   if (-not $Certificate) {
       $Certificate = Find-PanGPACertificate
   }
   $ItemPropertyConfig = @{
       Path = 'HKCU:\Software\Palo Alto Networks\GlobalProtect\PanMSAgent'
       Name = "previousCertificate"
       Value = New-PanGPACertificateString -Certificate $Certificate
   }
   if (-not (Test-Path -Path $ItemPropertyConfig.Path)) {
       New-Item -Path $ItemPropertyConfig.Path -Force | Out-Null
   }
   Set-ItemProperty @ItemPropertyConfig
}