#!/bin/bash

while true; do
    # Generar un número aleatorio entre 5 y 100
    interval=$(( RANDOM % 96 + 5 ))

    # Iniciar el contenedor
    docker start monero
    echo "Monero miner started."

    # Esperar un intervalo aleatorio
    sleep $interval

    # Detener el contenedor
    docker stop monero
    echo "Monero miner stopped."

    # Esperar un intervalo aleatorio antes de la próxima acción
    sleep 10
done

