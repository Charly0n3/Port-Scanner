#!/bin/bash
#Autor: Ch4rly0n3

#Colors

green="\e[0;32m\033[1m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"
end="\033[0m\e[0m"

### Dependencies ###

dependencies() {
        dep=(nc toilet)
        for program in "${dep[@]}"; do

                test -f /usr/bin/$program

                if [ "$(echo $?)" == "0" ]; then
                        echo -e "\n${green}- [V]${end} $program \n"
                else
                        echo -e "${red}- [X]${end} $program"
                        echo -e "[*] Instalando herramienta.."
                        apt-get install $program -y > /dev/null 2>&1
                fi
        done
}

scaner() {
	ip=$(hostname -I)
	echo -e "\n Tu dirección IP es: ${green}$ip${end}"; sleep 2
	echo -e "\n ${red}[*]${end} ¿Cual es el objetivo a escanear?${blue} [EJEMPLO: 192.168.1.1]:${end} "
	echo
	read -p "--> " target
	echo
	echo -e "${green}[!]${end} Comenzando el escaneo.."; echo; sleep 2;
	for i in $(seq 1 1000); do

		nc -zv $target $i 2> /dev/null

		if [ $(echo $?) -eq 0 ]; then
			echo -e "Port: $i ${green}[OPEN]${end}\n"
		else
			echo -e "Port: $i [CLOSE]" > /dev/null
		fi
	done
	echo -e "${green}[!]${end} Escaneo completado"; sleep 2
	echo -e "${green}[!]${end} Puertos escaneados: ${purple}1000${end}"; sleep 2
	echo -e "${green}[!]${end} Saliendo de el script..."; sleep 1
	exit 0
}

# Main function


if [ $(id -u ) -eq "0" ]; then
	clear
	echo -e "${red}Comprobando dependencias..${end}"; sleep 2
	dependencies
	echo
	toilet --font mono12 --filter border:metal --termwidth 'SCAN-PORTS'
	echo
	scaner

else
	clear; sleep 1
	echo -e "${red}[*]${end} Debes ejecutar el script como root"; sleep 1
	echo -e "\n ${red}EJEMPLO:${end} sudo bash scanports.sh"; sleep 1
	exit 1
fi
