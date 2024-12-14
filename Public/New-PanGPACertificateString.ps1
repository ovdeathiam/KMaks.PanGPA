function New-PanGPACertificateString {
    param(
        [Parameter(Mandatory,
                   Position=1)]        
        [System.Security.Cryptography.X509Certificates.X509Certificate2] $Certificate
    )

    [string] $String = $Certificate.GetName() -replace 'CN='
    $String += ' issued by '
    $String += $Certificate.GetIssuerName() -replace '\w\w='
    $String += ' sha1 hash is '
    $String += $Certificate.Thumbprint.ToLower() -replace '(\w{2})','$1 '
    return $String
}