function Find-PanGPACertificate {
    param ()
    Get-ChildItem -Path 'Cert:\LocalMachine\My\' |
    Where-Object -FilterScript {
        $_.Subject -match $env:COMPUTERNAME -and
        $_.EnhancedKeyUsageList.ObjectId -contains @('1.3.6.1.5.5.7.3.1')
    }
}