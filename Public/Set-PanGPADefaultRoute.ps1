function Set-PanGPADefaultRoute {
    param(
        [Parameter(Mandatory)]
        [ValidateSet("Wi-Fi","NetMgmt")]
        [string]
        $InterfaceAlias
    )

    $PrimaryRoute = Get-NetRoute | Where-Object -FilterScript {
        $_.InterfaceAlias -eq $InterfaceAlias -and
        $_.DestinationPrefix -eq "0.0.0.0/0"
    }
    $SecondaryRoute = Get-NetRoute | Where-Object -FilterScript {
        $_.InterfaceAlias -ne $InterfaceAlias -and $_.DestinationPrefix -eq "0.0.0.0/0"
    }
    $PrimaryRoute | Set-NetRoute -RouteMetric 0
    $SecondaryRoute | Set-NetRoute -RouteMetric 256
}