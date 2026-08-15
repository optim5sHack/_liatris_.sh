#!/bin/bash

YELLOW='\033[1;33m'
NC='\033[0m'
clear

# ----------------------------------------------------------------
# ACTUALIZO SISTEMA
# ----------------------------------------------------------------
echo -e "${YELLOW}Actualizar sistema: ${NC}"
read -p "¿Quieres actualizar sistema? (s/n): " respuestasistemaactualizado

if [[ "$respuestasistemaactualizado" =~ ^[sS]$ ]]; then
apt update 
apt upgrade
else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# INSTALO BASICOS
# ----------------------------------------------------------------
echo -e "${YELLOW}Instalación de herramientas básicas: ${NC}"
read -p "¿Quieres instalar herramientas básicas? (s/n): " respuestainstalacionesbasicas

if [[ "$respuestainstalacionesbasicas" =~ ^[sS]$ ]]; then
    apt install -y nmap tcpdump\
    iputils-ping lm-sensors iproute2 sudo vim iproute2 curl btop iftop lsof \
    lsb-release wget sysstat snmp snmpd tcpdump \
    ngrep iptraf-ng mlocate plocate tar gzip tree ca-certificates \
    screen man-db mailutils dnsutils rsyslog locales snmp snmpd smartmontools
else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# INSTALO HERRAMIENTAS
# ----------------------------------------------------------------
echo -e "${YELLOW}Instalar herramientas hacking: ${NC}"
read -p "¿Quieres instalar herramientas de pentesting? (s/n): " respuestainstalaciones

if [[ "$respuestainstalaciones" =~ ^[sS]$ ]]; then
    apt install -y nmap john hydra sqlmap whatweb tshark exiftool aircrack-ng
    echo "Paquetes de ciberseguridad instalados:"
    echo "nmap, john, hydra, sqlmap, whatweb, tshark, exiftool, aircrack-ng."
else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# SSH
# ----------------------------------------------------------------
echo -e "${YELLOW}Configuración ssh: ${NC}"
read -p "¿Quieres configurar ssh? (s/n): " respuestassh

if [[ "$respuestassh" =~ ^[sS]$ ]]; then
sed -i '/#PermitRootLogin/a PermitRootLogin yes' /etc/ssh/sshd_config
sed -i '/#AddressFamily any/a AddressFamily inet' /etc/ssh/sshd_config
sed -i '/#ListenAddress 0.0.0.0/a ListenAddress 0.0.0.0' /etc/ssh/sshd_config
systemctl restart sshd &>/dev/null
else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# MOTD	
# ----------------------------------------------------------------
echo -e "${YELLOW}Configurar MOTD: ${NC}"
read -p "¿Quieres configurar motd? (s/n): " respuestamotd

if [[ "$respuestamotd" =~ ^[sS]$ ]]; then
lsb_release -sd >> /etc/motd
uname -srm >> /etc/motd
else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# IDIOMA
# ----------------------------------------------------------------	
echo -e "${YELLOW}Instalar idioma: ${NC}"
read -p "¿Quieres instalar idioma? (s/n): " respuestaidioma

if [[ "$respuestaidioma" =~ ^[sS]$ ]]; then

localectl set-locale LANG=en_US.UTF-8
localectl
timedatectl set-timezone Europe/Madrid
else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# HORA
# ----------------------------------------------------------------
echo -e "${YELLOW}Instalar horario: ${NC}"
read -p "¿Quieres configurar hora? (s/n): " respuestahora

if [[ "$respuestahora" =~ ^[sS]$ ]]; then
apt install -y systemd-timesyncd &>/dev/null
systemctl enable systemd-timesyncd &>/dev/null
systemctl start systemd-timesyncd &>/dev/null
timedatectl set-timezone Europe/Madrid
timedatectl set-ntp true
else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# SAR
# ----------------------------------------------------------------
echo -e "${YELLOW}Instalar SAR: ${NC}"
read -p "¿Quieres configurar sar? (s/n): " respuestasar

if [[ "$respuestasar" =~ ^[sS]$ ]]; then
sed -i 's/ENABLED="false"/ENABLED="true"/g' /etc/default/sysstat
systemctl enable sysstat &>/dev/null
systemctl start sysstat	&>/dev/null
else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# Configuramos VIMRC
# ----------------------------------------------------------------
echo -e "${YELLOW}Configuración vimrc: ${NC}"
read -p "¿Quieres configurar el vimrc? (s/n): " respuestavimrc

if [[ "$respuestavimrc" =~ ^[sS]$ ]]; then
cat <<EOF > $HOME/.vimrc
" Isaac 2025 - 2026.05.14
set number                                    " Muestra números de línea
set cursorline                                " Resalta línea actual
set scrolloff=5                               " Mantiene 5 líneas arriba/abajo
set incsearch                                 " Búsqueda incremental
set hlsearch                                  " Resalta resultados búsqueda
set ignorecase                                " Ignora mayúsculas/minúsculas
set smartcase                                 " Caso sensible si hay mayúsculas
set expandtab                                 " Usa espacios en lugar de tabs
set tabstop=4                                 " Número de espacios que representa un tabulador
set shiftwidth=4                              " Número de espacios para indentación automática
set wildmenu                                  " Mejor autocompletado en la línea de comandos
syntax on                                     " Activa el resaltado de sintaxis
set background=dark                           " Tema oscuro para el fondo

" Colores personalizados básicos para consola
highlight Normal ctermfg=248 ctermbg=236      " Texto gris medio / fondo gris carbón
highlight LineNr ctermfg=240                  " Números gris oscuro
highlight CursorLine ctermbg=238              " Fondo línea cursor gris plomo
highlight Keyword ctermfg=61                  " Palabras clave azul cobalto apagado
highlight Function ctermfg=94                 " Funciones púrpura oscuro
highlight Statement ctermfg=124               " Sentencias rojo sangre oscuro
highlight Visual ctermbg=240                  " Selección gris oscuro
highlight Comment ctermfg=3                   " Comentarios en amarillo

set laststatus=2                              " Siempre mostrar línea de estado
set noerrorbells                              " Sin sonidos de error
set clipboard=unnamedplus                     " Usa portapapeles del sistema
EOF
else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# .BASHRC
# ----------------------------------------------------------------
echo -e "${YELLOW}Configuración .bashrc: ${NC}"
read -p "¿Quieres configurar archivo .bashrc? (s/n): " respuestabashrc

if [[ "$respuestabashrc" =~ ^[sS]$ ]]; then
cat <<EOF > ~/.bashrc
# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 is set in /etc/profile, and the default umask is defined
# in /etc/login.defs. You should not need this unless you want different
# defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# Titulo de ventana para putty
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

# Fancy bash prompt
PS1='\[\e[0;90m\]\u\[\e[1;35m\][\H]\[\e[0m\] \[\e[1;37;41m\] \w \[\e[0m\]$: '

# Custom ls colors
export LS_COLORS="di=90:fi=37:ln=1;33:so=1;37:pi=1;33:bd=90:cd=90:or=1;31:mi=1;31:ex=1;35"
#     di — directorios en gris oscuro técnico (bold black)
#     fi — archivos normales en gris medio
#     ln — enlaces simbólicos en amarillo (bold yellow)
#     so — sockets en blanco brillante (bold white)
#     pi — pipes (tuberías) en amarillo (bold yellow)
#     bd — dispositivos de bloque en gris carbón (bold black)
#     cd — dispositivos de carácter en gris plomo (bold black)
#     or — archivos rotos en rojo brillante (bold red)
#     mi — archivos inexistentes en rojo brillante (bold red)
#     ex — ejecutables en morado brillante (bold magenta)

# Custom aliases
alias clean='clear && source /etc/profile.d/motd-ascii.sh'
alias cp='cp -i'
alias df='df --exclude-type=tmpfs'
alias grep='grep --color=auto'
alias la='ls -lah --color=auto --group-directories-first'
alias ls='ls --color=auto --group-directories-first'
alias mv='mv -i'
alias rm='rm -i'
alias lsblk='lsblk -e7 -o NAME,MAJ:MIN,RM,SIZE,RO,TYPE,MOUNTPOINT,FSTYPE,MODEL,MODE,STATE,VENDOR,UUID'
alias find='find ./ -name'

# alias de pentesting
alias _kaonashi_descrypt='john --wordlist=/pentesting/diccionarios/kaonashi.txt --format=descrypt /pentesting/hash.txt'
alias _kaonashi_md5='john --wordlist=/pentesting/diccionarios/kaonashi.txt --format=md5crypt /pentesting/hash.txt'
alias _kaonashi_crypt_rules='john --session=yescrypt_run --wordlist=/pentesting/diccionarios/kaonashi.txt --rules --format=crypt /pentesting/hash.txt'
alias _kaonashi_sha1='john --wordlist=/pentesting/diccionarios/kaonashi.txt --format=raw-sha1 /pentesting/hash.txt'
alias _kaonashi_sha256='john --wordlist=/pentesting/diccionarios/kaonashi.txt --format=raw-sha256 /pentesting/hash.txt'
alias _kaonashi_sha512='john --wordlist=/pentesting/diccionarios/kaonashi.txt --format=sha512crypt /pentesting/hash.txt'
alias _tshark='tshark -i eth0 -f "not host 192.168.1.202"'

export VISUAL=vim
export EDITOR=vim
EOF
source ~/.bashrc
else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# LOGS
# ----------------------------------------------------------------
echo -e "${YELLOW}Configuración logs: ${NC}"
read -p "¿Quieres configurar el sistema de logs? (s/n): " respuestalogs

if [[ "$respuestalogs" =~ ^[sS]$ ]]; then
cat <<EOF > /etc/logrotate.conf
# logrotate.conf
# Isaac 2025 - 2026.05.14
weekly
rotate 52          # 52 semanas = 1 año
dateext
compress
notifempty
maxage 730         # elimina logs > 730 días (2 años)
create 640 root adm
include /etc/logrotate.d
EOF
# reinicio servicio de logs
systemctl enable rsyslog
systemctl restart rsyslog
else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# AGREGO CALAVERA
# ----------------------------------------------------------------
echo -e "${YELLOW}Agrego ascii al iniciar sesion: ${NC}"
read -p "¿Quieres agregar ascii al iniciar sesion? (s/n): " respuestascii

if [[ "$respuestascii" =~ ^[sS]$ ]]; then
cat <<'EOF' > /etc/profile.d/motd-ascii.sh
#!/bin/bash
# Mostrar ASCII solo en terminal interactiva
case $- in
    *i*) ;;
    *) return ;;
esac

# información inicio de sesión
echo ""
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMWWXKOkxddooooooddxkO0KNWWM:MMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMWN0dl:;;;;;;;;;;;;;;;;;;;;;;;;;;::clxOXWWMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMWXko::;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:;;::cdOXWMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMWNOl:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;::lkKWMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMWKd:;:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;::lkXWMMMMMMMMMMMMMM"
echo "MMMMMMMMMW0o:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;::lONMMMMMMMMMMMMM"
echo "MMMMMMMMWKo:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;::cxXWMMMMMMMMMMM"
echo "MMMMMMMMXd:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;::dXWMMMMMMMMMM"
echo "MMMMMMMWOc:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;::xNMMMMMMMMMM"
echo "MMMMMMMNd:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;::l0WMMMMMMMM"
echo "MMMMMMWKo;;;;;;;;;;;;;;;;;;:;;:clickonce;::;;;;;;;suprememage+x8;:cdKNMMMMMM"
echo "MMMMMMWKo;;;;;;;;;;;;;;;;;;;;;;;;xXxhack;:;;;;;php-framework.com;:cxXMMMMMMM"
echo -e "MMMMMMMXo:;;;;;;;;;;;;;;;;;;;;;;;:loolx1:;;;;;;;;;;;\e[1;35m_liatris_.sh\e[0m;::xNMMMMMMM"
echo "MMMMMMMNx:;;;;;;;;;;;;;;;;;;;;;;;:00000d:;;;;;;;;;;;;;;;;:0oNNee;::oKMMMMMMM"
echo "MMMMMMMW0l:;;;;;;;;;;;;;;;;;;;;;;:00000O:;;;;;;;;;;;;;;;;:00000l;::oKWMMMMMM"
echo "MMMMMMMMNkc;;;;;;;;;;;;;;;;;;;;;;:00000x:;;;;;;;;;;;;;;;;:0000dl;::dXMMMMMMM"
echo "MMMMMMMMMNkc;;;;;;;;;;;;;;;;;;;;;:000000:;;;;;;;;;;;;;;;;:00000e;::kNMMMMMMM"
echo "MMMMMMMMMMNkc::;;;;;;;;;;;;;;;;;;:000000:;;;;;;;;;;;;;;;;:00000v;::OWMMMMMMM"
echo "MMMMMMMMMMMW0dc:;;;;;cl:;;;;;;;;;:000000:;;;;;;;;;;;;;;;;:00000e;::0WMMMMMMM"
echo "MMMMMMMMMMMMMN0o:;;;;col;;;;;;;;;:000000:;;;;;;;;;;:cl;;;:00000n;::0WMMMMMMM"
echo "MMMMMMMMMMMMMMWNOoc:;:lxo:;;:;;;;:000000:;;;;;;;;::lOkc;;:00000c;:lKWMMMMMMM"
echo "MMMMMMMMMMMMMMMMWN0occ:dOxl:ll;;;:000000:;;;;;;;;::dXKo:;:00000c::dXMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMNkodlcxXX00d:;::000000:;;;;;;;::dKWNkc;::::::cdKWMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMWNOoc::oXWWNk:;;;;;;;;;;;;;;;;::dKNXN0l;::xxkx0NWMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMNkc::xNMMWKd::::::::::::::::::xKOkKOl:::xWWMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMNx::l0WMMMWN0xddddk0NWMWNxlc::::cc:cl:::KMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMW0l::cONMMMMMMMWWWWWMMMMMWKo:;:c:;:::;cl:KKMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMWOcc::0WMMMMMMMMMMMMMMMMMWkc;;coc;:ll::odoONMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMWKoc::xXWMMMMMMMMMMMMMMMMW0dlokdc:oxod0XNWMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMWddlook0KNWWMMMMMMMMMMMMWNXNWX0KNNNWWMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMWKOdollookKKO0KXWWWWNX0dkXWMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMWNKOdlll:::cdxdkOdodloKWMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMWWKxc:::cc:clccdkKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNkc;;;;;:::dKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN0dooodoldKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWWWNXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
# ================= INFO DEL SISTEMA =================
echo "Información del sistema:"

# Obtener información de la CPU
CPU_INFO=$(grep -m1 'model name' /proc/cpuinfo | cut -d ':' -f2 | sed 's/^ //')
# Obtener RAM libre
RAM_LIBRE=$(free -h | awk '/^Mem:/ {print $7}')
# Obtener espacio libre en la raíz
DISK_LIBRE=$(df -h / | awk '$NF=="/" {print $4}')
# Obtener uso de disco
DISK_USED=$(df -h / | awk '$NF=="/" {print $3}')
# Obtener total de disco
DISK_TOTAL=$(df -h / | awk '$NF=="/" {print $2}')
# Obtener uptime
UPTIME_FMT=$(awk '{
  printf "%d days, %d hours, %d minutes",
  int($1/86400),
  int(($1%86400)/3600),
  int(($1%3600)/60)
}' /proc/uptime)

echo -e "\e[1;35mCPU: \e[0m$CPU_INFO"
echo -e "\e[1;35mRAM libre: \e[0m$RAM_LIBRE"
echo -e "\e[1;35mEspacio libre en /: \e[0m$DISK_LIBRE"
echo -e "\e[1;35mEspacio usado en /: \e[0m$DISK_USED"
echo -e "\e[1;35mEspacio total en /: \e[0m$DISK_TOTAL"
echo -e "\e[1;35mTiempo desde el último arranque: \e[0m$UPTIME_FMT"

uname -srm
EOF
else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# MODIFICAR EL HOSTNAME
# ----------------------------------------------------------------
echo -e "${YELLOW}Cambiar hostname: ${NC}"
read -p "¿Deseas agregar un nuevo hostname? (s/n): " respuestaHost

if [[ "$respuestaHost" =~ ^[sS]$ ]]; then
    read -p "Introduce el nuevo hostname (optim5shack.youtube): " new_hostname

    # Actualizar /etc/hostname
    echo "$new_hostname" | sudo tee /etc/hostname > /dev/null

    # Actualizar /etc/hosts
    sudo tee /etc/hosts > /dev/null <<EOF
127.0.0.1   localhost
127.0.1.1   $new_hostname

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF

    # Actualizar hostname en tiempo real y en systemd
    sudo hostnamectl set-hostname "$new_hostname"

    echo "El hostname se ha cambiado a: $new_hostname"
else
    echo "Continuando con la instalación sin cambiar el hostname."
fi

# ----------------------------------------------------------------
# DESHABILITAR IPV6
# ----------------------------------------------------------------
echo -e "${YELLOW}Deshabilitar ipv6: ${NC}"
read -p "¿Deseas deshabilitar ipv6? (s/n): " respuestaipv6

if [[ "$respuestaipv6" =~ ^[sS]$ ]]; then
    # Reinicio red
    systemctl restart networking

    # Deshabilito IPv6
    echo -e "# Deshabilitamos IPv6\nnet.ipv6.conf.all.disable_ipv6 = 1\nnet.ipv6.conf.default.disable_ipv6 = 1\nnet.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p
      
    # Compruebo que no devuelve IPV6
    ip -6 addr show

else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# ARCHIVO SWAP
# ----------------------------------------------------------------
echo -e "${YELLOW}Configuración de archivo swap: ${NC}"
read -p "¿Deseas crear un archivo swap? (s/n): " respuestaswap

if [[ "$respuestaswap" =~ ^[sS]$ ]]; then
    read -p "Introduce en GB el total de memoria (ej: 2G, 4G, 8G): " new_swap
    # crear archivo swap de XGB
    sudo fallocate -l "$new_swap" /swapfile
    
    # dar permisos correctos
    sudo chmod 600 /swapfile
    
    # formatear como swap
    mkswap /swapfile
    
    # activar swap
    sudo swapon /swapfile
    
    # verificar que está activo
    swapon --show
    free -h
    
    # para que el swapfile se active en cada arranque, añade esta línea a /etc/fstab
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

    echo "Configuración completada con archivo swap: /swapfile - "$respuestaswap"B."

else
    echo "Continuando con la instalación..."
fi

# ----------------------------------------------------------------
# REINICIAR SERVIDOR
# ----------------------------------------------------------------
echo -e "${YELLOW}Reiniciar servidor: ${NC}"
read -p "¿Deseas reiniciar servidor? (s/n): " respuestaReiniciar
    # Reinicio
    reboot
else
    echo "Hack the world."
fi
# ----------------------------------------------------------------



