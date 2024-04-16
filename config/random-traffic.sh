#!/bin/bash

# Lista de las 20 URLs
urls=(
    "https://www.google.com"
    "https://www.youtube.com"
    "https://www.facebook.com"
    "https://www.wikipedia.org"
    "https://www.amazon.com"
    "https://www.reddit.com"
    "https://www.yahoo.com"
    "https://www.netflix.com"
    "https://www.instagram.com"
    "https://www.twitter.com"
    "https://www.linkedin.com"
    "https://www.microsoft.com"
    "https://www.apple.com"
    "https://www.baidu.com"
    "https://www.qq.com"
    "https://www.taobao.com"
    "https://www.tmall.com"
    "https://www.sohu.com"
    "https://www.jd.com"
    "https://www.live.com"
)

# Obtener el tamaño de la lista de URLs
num_urls=${#urls[@]}

# Obtener el número de interfaces disponibles
num_interfaces=$(ls -l /sys/class/net/ | grep -c 'uesimtun')

# Bucle infinito para simular tráfico continuo
while :
do
    # Seleccionar aleatoriamente una URLd
    random_index=$((RANDOM % num_urls))
    random_url="${urls[random_index]}"

    # Seleccionar aleatoriamente una interfaz de uesimtun0 a uesimtun(N-1)
    random_interface="uesimtun$((RANDOM % num_interfaces))"

    # Realizar una consulta HTTP GET a la URL seleccionada utilizando la interfaz seleccionada
    curl -i --interface "$random_interface" "$random_url" &

    # Esperar un breve período de tiempo antes de realizar la siguiente consulta
    sleep 2
done
