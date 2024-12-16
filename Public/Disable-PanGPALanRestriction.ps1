function Disable-PanGPALanRestriction {
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
        for ($i = 0; $i -lt 5; $i++) {
            $Route | Set-NetRoute -RouteMetric 1024
        }
    }
}