param(
    [Parameter(Mandatory = $true, Position = 0)]
    [int]$Port,

    [Parameter(Position = 1)]
    [string]$Host_ = '127.0.0.1',

    [int]$TimeoutSec = 3
)

if ($Port -lt 1 -or $Port -gt 65535) {
    Write-Error "El puerto $Port esta fuera de rango (1-65535)."
    exit 1
}

try {
    $client = New-Object System.Net.Sockets.TcpClient
    $iar = $client.BeginConnect($Host_, $Port, $null, $null)

    if ($iar.AsyncWaitHandle.WaitOne($TimeoutSec * 1000, $false) -and $client.Connected) {
        $client.EndConnect($iar)
        Write-Host "El puerto $Port en $Host_ esta ABIERTO." -ForegroundColor Green
        $client.Close()
        exit 0
    }
    else {
        Write-Host "El puerto $Port en $Host_ esta CERRADO." -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Host "El puerto $Port en $Host_ esta CERRADO." -ForegroundColor Red
    exit 1
}
finally {
    if ($client) { $client.Close() }
}