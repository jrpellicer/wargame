#!/bin/bash

# Comprobar sudo
if [ "$(id -u)" != "0" ]; then
    echo "Este script necesita ser ejecutado con permisos de superusuario (sudo)."
    exit 1
fi

# Directorio donde está instalado este script
script=$(readlink -f $0)
dirbase=`dirname $script`

# Niveles (incluido el 0)
niveles=18

# Directorio donde se almacenarán las contraseñas
password_dir="/etc/turtle_pass"

# Comprobar que no se ha ejecutado la instalación
if [ -d "$password_dir" ]; then
    echo "Este script ya se ha ejecutado."
    exit 1
fi

# Deshabilitamos mensajes de bienvenida
chmod -x /etc/update-motd.d/*

# Quitamos texto legal para que no aparezca al iniciar sesión
mv /etc/legal /etc/legal.old

# Quitamos información de último inicio de sesión
sed -i 's/#PrintLastLog yes/PrintLastLog no/' /etc/ssh/sshd_config

# Quitamos permiso de lectura en /tmp
chmod o-r /tmp

# Instalar figlet
apt update
apt install figlet -y

# Instalar bzip2 y xxd
apt install bzip2 xxd git -y

# Crear el directorio si no existe
if [ ! -d "$password_dir" ]; then
    mkdir -p "$password_dir"
fi

# Crear 15 usuarios
for ((i=0; i<$niveles; i++)); do
    username="turtle$(printf '%02d' $i)"
    
    # Determinar la contraseña del usuario
    if [ $i -eq 0 ]; then
        password="turtle00"
    else
        password=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)
    fi

    # Crear el usuario
    useradd -m -d "/home/$username" -s /bin/bash -U "$username"

    # Establecer la contraseña del usuario
    echo "$username:$password" | chpasswd

    # Crear el archivo de contraseña en el directorio correspondiente
    password_file="$password_dir/$username"
    echo "$password" > "$password_file"

    # Establecer propietario del archivo al usuario y permisos de solo lectura
    chown "$username:$username" "$password_file"
    chmod 400 "$password_file"

    # Establecer propietario y permisos de la carpeta personal
    user_home="/home/$username"
    chown root:root "$user_home"
    chmod 755 "$user_home"

    # Añadir banner con nivel
    echo "figlet Nivel" $i | sudo tee -a "$user_home"/.bashrc > /dev/null
    echo "echo" | sudo tee -a "$user_home"/.bashrc > /dev/null
done

##################
# Level 0
##################
echo "La contraseña del siguiente nivel es `cat /etc/turtle_pass/turtle01`" > /home/turtle00/readme
chown turtle00:turtle00 /home/turtle00/readme

echo "clear" >> /home/turtle00/.bashrc 
echo "figlet 'Pensamiento Profundo'" >> /home/turtle00/.bashrc 
echo "echo" >> /home/turtle00/.bashrc
echo "echo Bienvenido a Pensamiento Profundo, la segunda mejor supercomputadora de todos los tiempos." >> /home/turtle00/.bashrc
echo "echo" >> /home/turtle00/.bashrc
echo "echo Fue construida por un grupo de exploradores de una raza de seres pandimensionales e hiperinteligentes con el fin" >> /home/turtle00/.bashrc
echo "echo de obtener la respuesta al sentido de la vida, del universo y todo lo demás." >> /home/turtle00/.bashrc
echo "echo" >> /home/turtle00/.bashrc
echo "echo Si deseas averiguar la respuesta de semejante pregunta filosófica, deberás ayudar al Sr. Tortuga a pasar todos los niveles" >> /home/turtle00/.bashrc
echo "echo de la supercomputadora Pensamiento Profundo." >> /home/turtle00/.bashrc
echo "echo" >> /home/turtle00/.bashrc
echo "echo Pero ojo, el Sr. Cangrejo nos lo va a poner difícil, y nos va a sembrar el camino de trampas y engaños." >> /home/turtle00/.bashrc
echo "echo ¿Podrás ayudar al Sr. Tortuga a llegar hasta el final?" >> /home/turtle00/.bashrc 
echo "figlet 'Nivel 0'" >> /home/turtle00/.bashrc
echo "echo" >> /home/turtle00/.bashrc 
echo "echo -e 'La contraseña para el nivel 1 la encontrarás en un archivo llamado readme.\n'" >> /home/turtle00/.bashrc
echo "echo -e 'Comandos relacionados: ls, cat, exit\n'" >> /home/turtle00/.bashrc

##################
# Level 1
##################
mkdir /home/turtle01/inhere
cat /etc/turtle_pass/turtle02 > /home/turtle01/inhere/.oculto
chown turtle01:turtle01 /home/turtle01/inhere -R
chmod 500 /home/turtle01/inhere
chmod 400 /home/turtle01/inhere/.oculto

echo "echo -e 'El señor cangrejo ha escondido la contraseña del siguiente nivel en un fichero oculto.\n'" >> /home/turtle01/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat\n'" >> /home/turtle01/.bashrc

##################
# Level 2
##################
# Definir la matriz de nombres de archivos
file_names=("0x2A" "072" "10010011" "01000001" "11000010" "00011100" "clave" "codigo" "password" "0x11A" "0337")

# Crear archivos con los nombres de la matriz
for file_name in "${file_names[@]}"; do
    contenido=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)
    echo "$contenido" > "/home/turtle02/$file_name"
    chown turtle02:turtle02 /home/turtle02/$file_name
    chmod 400 /home/turtle02/$file_name
done

# Crear archivos trampa
cp cangrejo /home/turtle02/.AA
chown turtle02:turtle02 /home/turtle02/.AA
chmod 400 /home/turtle02/.AA

cp tortuga /home/turtle02/.aa
chown turtle02:turtle02 /home/turtle02/.aa
chmod 400 /home/turtle02/.aa

# Crear archivo con la clave
cat /etc/turtle_pass/turtle03 > /home/turtle02/10101010
chown turtle02:turtle02 /home/turtle02/10101010
chmod 400 /home/turtle02/10101010

echo "echo -e 'El señor cangrejo es un enamorado de los sistemas de numeración hexadecimal y binario, y ha guardado la contraseña en un fichero que está relacionado doblemente con la primera letra del abecedario.\n'" >> /home/turtle02/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat, grep, file\n'" >> /home/turtle02/.bashrc

##################
# Level 3
##################
for ((i=0; i<290; i++)); do
    contenido=$(< /dev/urandom tr -dc '@#!&)(%= A-Za-z0-9' | head -c 42 ; echo)
    echo "$contenido" >> /home/turtle03/random
    if [ $i -eq 71 ]; then
        echo "p@ssW0rd: `cat /etc/turtle_pass/turtle04`" >> /home/turtle03/random
    fi
done
chown turtle03:turtle03 /home/turtle03/random
chmod 400 /home/turtle03/random

echo "echo -e 'La contraseña del siguiente nivel está almacenada junto a la cadena de texto p@ssW0rd.\n'" >> /home/turtle03/.bashrc 
echo "echo -e 'Comandos relacionados: ls, cd, cat, find, grep, file\n'" >> /home/turtle03/.bashrc

##################
# Level 4
##################
# Definir la matriz de nombres de archivos
file_names=("-fichero1" ".fichero1" "-fichero2" ".fichero2" "fichero3" ".fichero3" "-fichero3")

# Crear los directorios
for ((i=0; i<20; i++)); do
    dirname="quizas_aqui_$(printf '%02d' $i)"
    mkdir /home/turtle04/$dirname
    chown turtle04:turtle04 /home/turtle04/$dirname
    chmod 500 /home/turtle04/$dirname
    # Crear los archivos
    for file_name in "${file_names[@]}"; do
        tamanyo=`echo $(($RANDOM%9900))`
        contenido=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c $tamanyo ; echo)
        echo "$contenido" > "/home/turtle04/$dirname/$file_name"
        chown root:turtle04 /home/turtle04/$dirname/$file_name
	if [ "$file_name" == "-fichero2" -o "$file_name" == ".fichero2" -o "$file_name" == "fichero2" ]
        then
            chmod 640 /home/turtle04/$dirname/$file_name
        else
            chmod 750 /home/turtle04/$dirname/$file_name
        fi
    done
done
(cat /etc/turtle_pass/turtle05 ; < /dev/urandom tr -dc " " | head -c 1000) > /home/turtle04/quizas_aqui_07/.fichero2

echo "echo -e 'La contraseña del siguiente nivel está almacenada en un fichero de 1033 bytes que no es ejecutable.\n'" >> /home/turtle04/.bashrc 
echo "echo -e 'Comandos relacionados: ls, cd, cat, find, file\n'" >> /home/turtle04/.bashrc

##################
# Level 5
##################
chgrp turtle05 /etc/turtle_pass/turtle06
chmod g+r /etc/turtle_pass/turtle06

echo "echo -e 'La contraseña del siguiente nivel está almacenada en un fichero de 33 bytes cuyo grupo porpietario es turtle05, su usuario propietario es turtle06 y se encuentra ubicado en cualquier lugar del servidor. (PISTA: estaría bien redireccionar la salida de error a /dev/null)\n'" >> /home/turtle05/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat, find, grep, file\n'" >> /home/turtle05/.bashrc

##################
# Level 6
##################
for ((i=0; i<70; i++)); do
	password=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)
	echo $password >> /home/turtle06/passwords
done
cat /etc/turtle_pass/turtle07 >> /home/turtle06/passwords
for ((i=0; i<20; i++)); do
	password=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)
	echo $password >> /home/turtle06/passwords
done
cat /etc/turtle_pass/turtle07 >> /home/turtle06/passwords
for ((i=0; i<15; i++)); do
	password=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)
	echo $password >> /home/turtle06/passwords
done

echo "echo -e 'La contraseña del siguiente nivel es la única línea repetida del fichero donde el Sr. Cangrejo guarda las contraseñas.\n'" >> /home/turtle06/.bashrc 
echo "echo -e 'Comandos relacionados: ls, cd, cat, uniq, sort, find, grep, file\n'" >> /home/turtle06/.bashrc

##################
# Level 7
##################
ssh-keygen -t rsa -b 4096 -f /home/turtle07/clave.privada -N "" > /dev/null
chgrp turtle07 /home/turtle07/clave.privada
chmod g+r /home/turtle07/clave.privada
mkdir /home/turtle08/.ssh
chgrp turtle08 /home/turtle08/.ssh
mv /home/turtle07/clave.privada.pub /home/turtle08/.ssh/authorized_keys
chown turtle08:turtle08 /home/turtle08/.ssh/authorized_keys

echo "echo -e 'La contraseña del siguiente nivel está almacenada en /etc/turtle_pass/turtle08, pero desgraciadamente solo la puede ver el usuario de nivel 8. No te preocupes, el señor Cangrejo nos ha dejado una clave privada de SSH para poder pasar de nivel.\n'" >> /home/turtle07/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat, ssh, scp, ssh-keygen'" >> /home/turtle07/.bashrc
echo "echo -e 'Páginas de ayuda: https://help.ubuntu.com/community/SSH/OpenSSH/Keys\n'" >> /home/turtle07/.bashrc

##################
# Level 8
##################
for ((i=0; i<70; i++)); do
	password=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)
	echo $password >> /home/turtle08/passwords.old
	echo $password >> /home/turtle08/passwords.new
done
cat /etc/turtle_pass/turtle09 >> /home/turtle08/passwords.new
for ((i=0; i<20; i++)); do
	password=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)
	echo $password >> /home/turtle08/passwords.old
	echo $password >> /home/turtle08/passwords.new
done

echo "echo -e 'La contraseña del siguiente nivel es la única línea añadida del fichero nuevo de contraseñas.\n'" >> /home/turtle08/.bashrc 
echo "echo -e 'Comandos relacionados: ls, cd, cat, diff, sort, uniq, file\n'" >> /home/turtle08/.bashrc

##################
# Level 9
##################
echo "La contraseña del siguiente nivel es `cat /etc/turtle_pass/turtle10`"| tr A-Za-z N-ZA-Mn-za-m > /home/turtle09/data.txt

echo "echo -e 'El Sr. Cangrejo es un amante de la criptografía y le gusta jugar con el cifrado César.\n'" >> /home/turtle09/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat, tr, diff, sort, uniq, file'" >> /home/turtle09/.bashrc
echo "echo -e 'Páginas de ayuda: https://es.wikipedia.org/wiki/ROT13\n'" >> /home/turtle09/.bashrc

##################
# Level 10
##################
echo "La contraseña del siguiente nivel es `cat /etc/turtle_pass/turtle11`" | base64 > /home/turtle10/data.txt

echo "echo -e 'Como el cifrado César te ha resultado muy sencillo, el Sr. Cangrejo ha decidido utilizar la codificación base64.\n'" >> /home/turtle10/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat, file, tr, base64, xxd, md5sum'" >> /home/turtle10/.bashrc
echo "echo -e 'Páginas de ayuda: https://es.wikipedia.org/wiki/Base64\n'" >> /home/turtle10/.bashrc

##################
# Level 11
##################
tar c /etc/turtle_pass/turtle12 | gzip | bzip2 | gzip | xxd > /home/turtle11/password.hex

echo "echo -e 'La contraseña del siguiente nivel encontrarás si logras revertir el volcado hexadecimal de un fichero que ha estado múltiples veces comprimido y agrupado.\n'" | sudo tee -a /home/turtle11/.bashrc > /dev/null
echo "echo -e 'Para trabajar mejor, créate un directorio de trabjo en /tmp y copia en él ese misterioso fichero que nos ha dejado el Sr. Cangrejo.\n'" >> /home/turtle11/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, mkdir, cp, cat, file, tar, xxd, gzip, gunzip, bzip2, bunzip2'" >> /home/turtle11/.bashrc
echo "echo -e 'Páginas de ayuda: https://en.wikipedia.org/wiki/Hex_dump\n'" >> /home/turtle11/.bashrc

##################
# Level 12
##################
mkdir /home/turtle12/passwords

for ((i=0; i<78; i++)); do
    filename="/home/turtle12/passwords/password$(printf '%02d' $i)"
    
    # Crear passwords aleatorios
    password=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)

    # Crear el archivo de contraseña en el directorio correspondiente
    echo "$password" > "$filename"

done

cat /etc/turtle_pass/turtle13 > /home/turtle12/passwords/password55
cat /etc/turtle_pass/turtle13 | md5sum > /home/turtle12/password.md5sum

echo "echo -e 'Cuidado, porque de entre todos los ficheros, sólo uno contiene el password. El Sr. Cangrejo nos ha dejado como pista el resultado de una función hash.\n'" >> /home/turtle12/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat, file, grep, cut, xargs, md5sum, sha256\n'" >> /home/turtle12/.bashrc

##################
# Level 13
##################
echo "La contraseña del siguiente nivel es `cat /etc/turtle_pass/turtle14`" > /home/turtle13/password

echo "echo -e 'La contraseña del siguiente nivel está almacenada en el fichero ~/password, pero el Sr. Cangrejo ha introducido un logout en ~/.bashrc.\n'" | sudo tee -a /home/turtle13/.bashrc > /dev/null
echo "echo -e 'Comandos relacionados: ls, cd, cat, ssh\n'" >> /home/turtle13/.bashrc
echo "logout" | sudo tee -a /home/turtle13/.bashrc > /dev/null

##################
# Level 14
##################
password=$(cat /etc/turtle_pass/turtle15)
groupadd $password
usermod turtle14 -aG $password

echo "echo -e 'Este usuario pertenece a un grupo secudario muy, pero que muy peculiar.\n'" | sudo tee -a /home/turtle14/.bashrc > /dev/null 
echo "echo -e 'Comandos relacionados: ls, cd, cat, file, id\n'" >> /home/turtle14/.bashrc

##################
# Level 15
##################
mkdir /opt/git/turtle.git -p

git -C /opt/git/turtle.git init
git -C /opt/git/turtle.git config user.email "cangrejo@example.com"
git -C /opt/git/turtle.git config user.name "Cangrejo"
echo "===============================================" > /opt/git/turtle.git/readme.md
echo " Usuario: turtle16" >> /opt/git/turtle.git/readme.md
echo " Contraseña: `cat /etc/turtle_pass/turtle16`" >> /opt/git/turtle.git/readme.md
echo "===============================================" >> /opt/git/turtle.git/readme.md
git -C /opt/git/turtle.git add .
git -C /opt/git/turtle.git commit -m "Commit inicial"
sed -i '/Contraseña/c\ Contraseña: XXXXXXXXX' /opt/git/turtle.git/readme.md
git -C /opt/git/turtle.git add .
git -C /opt/git/turtle.git commit -m "Ocultación de contraseña"

echo "echo -e 'La contraseña del siguente nivel está guardada en un fichero del repositorio localhost:/opt/git/turtle.git\n'" | sudo tee -a /home/turtle15/.bashrc > /dev/null 
echo "echo -e 'Pero ojo, el Sr. Cangrejo ha creado una nueva versión de ese fichero y ha borrado la contraseña.\n'" | sudo tee -a /home/turtle15/.bashrc > /dev/null 
echo "echo -e 'Comandos relacionados: ls, cd, cat, git clone, git log, git diff\n'" >> /home/turtle15/.bashrc

##################
# Level 16
##################
echo "@reboot python3 $dirbase/servidor.py" >> /etc/crontab
python3 $dirbase/servidor.py &

cp $dirbase/cangrejo /home/turtle16/
cp $dirbase/tortuga /home/turtle16/
chgrp turtle16 /home/turtle16/cangrejo
chmod 640 /home/turtle16/cangrejo
chgrp turtle16 /home/turtle16/tortuga
chmod 640 /home/turtle16/tortuga

echo "echo -e 'El Sr. Cangrejo ha dejado en localhost un servicio de red escuchando por un puerto alque le podemos mandar mensajes.'" | sudo tee -a /home/turtle16/.bashrc > /dev/null 
echo "echo -e 'La única pista que nos ha dado es que es un puerto que se encuentra entre el 20000 y el 30000.\n'" | sudo tee -a /home/turtle16/.bashrc > /dev/null
echo "echo -e 'Para que nos devuelva la respuesta correcta hemos de pasar un número octal de 3 cifras relacionado con los permisos del fichero cangrejo.\n'" | sudo tee -a /home/turtle16/.bashrc > /dev/null 
echo "echo -e 'Comandos relacionados: nmap, nc, ssh, ls\n'" >> /home/turtle16/.bashrc

##################
# Level 17
##################
echo -e "\n  La respuesta a la Gran Pregunta...\n\n\n\n                   ...del Sentido de La Vida, del Universo y de Todo Lo Demás ...\n\n\n\n        ...es...\n\n\n\n" > /home/turtle17/'La Respuesta'
figlet 42 -kc >> /home/turtle17/'La Respuesta'
echo -e "\n\n\n\nLa respuesta es correcta, pero si no te satisface, es porque la pregunta está mal formulada.\n\n" >> /home/turtle17/'La Respuesta'
chmod 644 /home/turtle17/'La Respuesta'

systemctl restart sshd

echo
echo "Contraseñas generadas"
echo "====================="
cat /etc/turtle_pass/turtle*
