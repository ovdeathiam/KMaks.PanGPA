function Enable-PanGPALanRestriction {
    [CmdletBinding()]
    param ()
    
    $PanGPInterface = Get-NetAdapter -InterfaceDescription "PANGP Virtual Ethernet Adapter Secure"

    $InterfaceIndexes = Get-NetAdapter | Select-Object -ExpandProperty InterfaceIndex

    $MaliciousRoutes = Get-NetRoute -InterfaceIndex $InterfaceIndexes |
    Group-Object -Property "DestinationPrefix" |
    Where-Object -FilterScript {
        $_.Count -eq 2 -and
        $_.Name -ne "0.0.0.0/0"
    } |
    Select-Object -ExpandProperty Group |
    Where-Object -FilterScript { $_.ifIndex -eq $PanGPInterface.InterfaceIndex }

    foreach ($Route in $MaliciousRoutes) {
        $Route | Set-NetRoute -RouteMetric 0
    }
}