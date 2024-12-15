function Enable-PanGPALanRestriction {
    [CmdletBinding()]
    param ()
    
    $PanGPInterface = Get-NetAdapter -InterfaceDescription "PANGP Virtual Ethernet Adapter Secure"

    $InterfaceIndexes = Get-NetAdapter | Select-Object -ExpandProperty InterfaceIndex

    Get-NetRoute -InterfaceIndex $InterfaceIndexes |
    Group-Object -Property "DestinationPrefix" |
    Where-Object -FilterScript {
        $_.Count -eq 2 -and
        $_.Name -ne "0.0.0.0/0"
    } |
    Select-Object -ExpandProperty Group |
    ForEach-Object -Process {
        Set-NetRoute -InterfaceIndex $PanGPInterface.InterfaceIndex -RouteMetric 0
    }
}