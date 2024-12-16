function Enable-PanGPADefaultRoute {
    param()

    $PanGPInterface = Get-NetAdapter -InterfaceDescription "PANGP Virtual Ethernet Adapter Secure"

    $DefaultRoutes = Get-NetRoute -DestinationPrefix '0.0.0.0/0'

    $PanGPARoute = $DefaultRoutes | Where-Object -FilterScript {
        $_.InterfaceIndex -eq $PanGPInterface.ifIndex
    }
    $DefaultRoute = $DefaultRoute | Where-Object -FilterScript {
        $_.InterfaceIndex -ne $PanGPInterface.ifAlias
    }

    $PanGPARoute | Set-NetRoute -RouteMetric 0
}