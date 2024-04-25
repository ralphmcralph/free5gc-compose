#!/bin/bash

# Obtener los nombres de las interfaces de red que empiezan con "uesimtun"
interfaces=$(ip -o link show | grep -oP 'uesimtun\d+')

# Inicializar el array para almacenar las direcciones IP
ip_addresses=()

# Recorrer las interfaces y obtener sus direcciones IP
for interface in $interfaces; do
    ip_address=$(ip -4 addr show $interface | awk '$1 == "inet" {print $2}' | cut -d '/' -f 1)
    ip_addresses+=("$ip_address")  # Agregar la dirección IP al array
done

# Imprimir la lista de direcciones IP disponibles
echo "Lista de direcciones IP disponibles:"
echo "${ip_addresses[@]}"  # Imprimir todas las direcciones IP del array

# Obtener la cantidad de direcciones IP disponibles
num_ips=${#ip_addresses[@]}
echo "Cantidad de direcciones IP disponibles: $num_ips"

# Seleccionar la dirección IP de la primera posición (índice 0)
first_ip="${ip_addresses[0]}"
echo "Dirección IP seleccionada (primera posición): $first_ip"

# Dirección IP del servidor iperf
#iperf_server="192.168.0.33"
#iperf_server = "speedtest.init7.net"
# Lista de anchos de banda típicos para aplicaciones de usuario final (en Mbps)
bandwidths=(
    "0.01M"  # Control
    "0.1M"   # Navegación web básica
    "1M"     # Streaming de audio de calidad estándar
    "3M"     # Streaming de video de definición estándar (SD)
    "5M"     # Streaming de video de alta definición (HD) / Videoconferencia
    "10M"    # Streaming de video de alta definición (HD) / Videoconferencia
    "20M"    # Streaming de video de ultra alta definición (UHD)
)

# Obtener el tamaño de las listas de anchos de banda y direcciones IP de las interfaces
num_bandwidths=${#bandwidths[@]}

# Bucle infinito para simular tráfico continuo
while :
do
    # Seleccionar aleatoriamente una dirección IP de la lista
    random_index=$((RANDOM % num_ips))
    ip_address="${ip_addresses[random_index]}"

    # Seleccionar aleatoriamente un ancho de banda
    random_bandwidth_index=$((RANDOM % num_bandwidths))
    bandwidth="${bandwidths[random_bandwidth_index]}"

    # Seleccionar aleatoriamente el tiempo entre 1 y 60 segundos
    random_connection_time=$((RANDOM % 60 + 1))

    # Realizar una prueba de velocidad iperf hacia el servidor seleccionado con la interfaz y ancho de banda especificados
    iperf3 -c spd-uswb.hostkey.com -R -b ${bandwidth} -B ${ip_address} -p 5201 -P 1 -t "${random_connection_time}" ;  sleep 10
done
