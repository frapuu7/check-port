#!/bin/bash

usage() {
    echo "Uso: $0 <puerto> [host]"
    echo "Ejemplo: $0 80"
    exit 1
}

[ -z "$1" ] && usage
PORT="$1"
HOST="${2:-127.0.0.1}"

if ! echo "$PORT" | grep -qE '^[0-9]+$' || [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
    echo "Error: '$PORT' no es un puerto valido (1-65535)."
    exit 1
fi

if timeout 3 bash -c "cat < /dev/null > /dev/tcp/$HOST/$PORT" 2>/dev/null; then
    echo "El puerto $PORT en $HOST esta ABIERTO."
    exit 0
else
    echo "El puerto $PORT en $HOST esta CERRADO."
    exit 1
fi