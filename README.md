# Verificar si un puerto esta abierto o cerrado

## Linux (Docker)

`check-port.sh` se ejecuta dentro del contenedor `bash:latest`.

```bash
# Puerto abierto
docker run --rm -v "$(pwd)/check-port.sh:/check-port.sh:ro" bash:latest bash /check-port.sh 80

# Puerto cerrado (exit code 1)
docker run --rm -v "$(pwd)/check-port.sh:/check-port.sh:ro" bash:latest bash /check-port.sh 9999
```

Equivalente en PowerShell (Windows):

```powershell
docker run --rm -v "${PWD}/check-port.sh:/check-port.sh:ro" bash:latest bash /check-port.sh 80
```

## Windows (PowerShell nativo)

```powershell
# Execute desde la carpeta del proyecto
.\check-port.ps1 -Port 80

# Con host explicito
.\check-port.ps1 -Port 80 -Host_ 127.0.0.1
```

Ambos scripts devuelven exit code `0` si el puerto esta abierto y `1` si esta cerrado.