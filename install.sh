#!/bin/bash

# Comprobar sudo
if [ "$(id -u)" != "0" ]; then
    echo "Este script necesita ser ejecutado con permisos de superusuario (sudo)."
    exit 1
fi

# Niveles (incluido el 0)
niveles=15

# Directorio donde se almacenarán las contraseñas
password_dir="/etc/carranc_pass"

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
apt install bzip2 xxd -y

# Crear el directorio si no existe
if [ ! -d "$password_dir" ]; then
    mkdir -p "$password_dir"
fi

# Crear 15 usuarios
for ((i=0; i<$niveles; i++)); do
    username="carranc$(printf '%02d' $i)"
    
    # Determinar la contraseña del usuario
    if [ $i -eq 0 ]; then
        password="carranc00"
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
echo "La contraseña del siguiente nivel es `cat /etc/carranc_pass/carranc01`" > /home/carranc00/readme
chown carranc00:carranc00 /home/carranc00/readme

echo "clear" >> /home/carranc00/.bashrc 
echo "figlet 'Pensamiento Profundo'" >> /home/carranc00/.bashrc 
echo "echo" >> /home/carranc00/.bashrc
echo "echo Bienvenido a Pensamiento Profundo, la segunda mejor supercomputadora de todos los tiempos." >> /home/carranc00/.bashrc
echo "echo" >> /home/carranc00/.bashrc
echo "echo Fue construida por un grupo de exploradores de una raza de seres pandimensionales e hiperinteligentes con el fin" >> /home/carranc00/.bashrc
echo "echo de obtener la respuesta al sentido de la vida, del universo y todo lo demás." >> /home/carranc00/.bashrc
echo "echo" >> /home/carranc00/.bashrc
echo "echo Si deseas averiguar la respuesta de semejante pregunta filosófica, deberás ayudar al Sr. Tortuga a pasar todos los niveles" >> /home/carranc00/.bashrc
echo "echo de la supercomputadora Pensamiento Profundo." >> /home/carranc00/.bashrc
echo "echo" >> /home/carranc00/.bashrc
echo "echo Pero ojo, el Sr. Cangrejo nos lo va a poner difícil, y nos va a sembrar el camino de trampas y engaños." >> /home/carranc00/.bashrc
echo "echo ¿Podrás ayudar al Sr. Tortuga a llegar hasta el final?" >> /home/carranc00/.bashrc 
echo "figlet 'Nivel 0'" >> /home/carranc00/.bashrc
echo "echo" >> /home/carranc00/.bashrc 
echo "echo -e 'La contraseña para el nivel 1 la encontrarás en un archivo llamado readme.\n'" >> /home/carranc00/.bashrc
echo "echo -e 'Comandos relacionados: ls, cat, exit\n'" >> /home/carranc00/.bashrc

##################
# Level 1
##################
mkdir /home/carranc01/inhere
cat /etc/carranc_pass/carranc02 > /home/carranc01/inhere/.oculto
chown carranc01:carranc01 /home/carranc01/inhere -R
chmod 500 /home/carranc01/inhere
chmod 400 /home/carranc01/inhere/.oculto

echo "echo -e 'El señor cangrejo ha escondido la contraseña del siguiente nivel en un fichero oculto.\n'" >> /home/carranc05/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat\n'" >> /home/carranc01/.bashrc

##################
# Level 2
##################
# Definir la matriz de nombres de archivos
file_names=("0x2A" "072" "10010011" "01000001" "11000010" "00011100" "clave" "codigo" "password" "0x11A" "0337")

# Crear archivos con los nombres de la matriz
for file_name in "${file_names[@]}"; do
    contenido=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)
    echo "$contenido" > "/home/carranc02/$file_name"
    chown carranc02:carranc02 /home/carranc02/$file_name
    chmod 400 /home/carranc02/$file_name
done

# Crear archivo con la clave
cat /etc/carranc_pass/carranc03 > /home/carranc02/10101010
chown carranc02:carranc02 /home/carranc02/10101010
chmod 400 /home/carranc02/10101010

echo "echo -e 'El señor cangrejo es un enamorado de los sistemas de numeración hexadecimal y binario, y ha guardado la contraseña en un fichero que está relacionado doblemente con la primera letra del abecedario.\n'" >> /home/carranc05/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat, file\n'" >> /home/carranc02/.bashrc

##################
# Level 3
##################
# Definir la matriz de nombres de archivos
file_names=("-fichero1" ".fichero1" "-fichero2" ".fichero2" "fichero3" ".fichero3" "-fichero3")

# Crear los directorios
for ((i=0; i<20; i++)); do
    dirname="quizas_aqui_$(printf '%02d' $i)"
    mkdir /home/carranc03/$dirname
    chown carranc03:carranc03 /home/carranc03/$dirname
    chmod 500 /home/carranc03/$dirname
    # Crear los archivos
    for file_name in "${file_names[@]}"; do
        tamanyo=`echo $(($RANDOM%9900))`
        contenido=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c $tamanyo ; echo)
        echo "$contenido" > "/home/carranc03/$dirname/$file_name"
        chown root:carranc03 /home/carranc03/$dirname/$file_name
	if [ "$file_name" == "-fichero2" -o "$file_name" == ".fichero2" -o "$file_name" == "fichero2" ]
        then
            chmod 640 /home/carranc03/$dirname/$file_name
        else
            chmod 750 /home/carranc03/$dirname/$file_name
        fi
    done
done
(cat /etc/carranc_pass/carranc04 ; < /dev/urandom tr -dc " " | head -c 1000) > /home/carranc03/quizas_aqui_07/.fichero2

echo "echo -e 'La contraseña del siguiente nivel está almacenada en un fichero de 1033 bytes que no es ejecutable.\n'" >> /home/carranc03/.bashrc 
echo "echo -e 'Comandos relacionados: ls, cd, cat, find, file\n'" >> /home/carranc03/.bashrc

##################
# Level 4
##################
chgrp carranc04 /etc/carranc_pass/carranc05
chmod g+r /etc/carranc_pass/carranc05

echo "echo -e 'La contraseña del siguiente nivel está almacenada en un fichero de 33 bytes cuyo grupo porpietario es carranc04, su usuario propietario es carranc05 y se encuentra ubicado en cualquier lugar del servidor. (PISTA: estaría bien redireccionar la salida de error a /dev/null)\n'" >> /home/carranc04/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat, find, file\n'" >> /home/carranc04/.bashrc

##################
# Level 5
##################
for ((i=0; i<70; i++)); do
	password=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)
	echo $password >> /home/carranc05/passwords
done
cat /etc/carranc_pass/carranc06 >> /home/carranc05/passwords
for ((i=0; i<20; i++)); do
	password=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)
	echo $password >> /home/carranc05/passwords
done
cat /etc/carranc_pass/carranc06 >> /home/carranc05/passwords
for ((i=0; i<15; i++)); do
	password=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)
	echo $password >> /home/carranc05/passwords
done

echo "echo -e 'La contraseña del siguiente nivel es la única línea repetida del fichero donde el Sr. Cangrejo guarda las contraseñas.\n'" >> /home/carranc05/.bashrc 
echo "echo -e 'Comandos relacionados: ls, cd, cat, uniq, sort, find, file\n'" >> /home/carranc05/.bashrc

##################
# Level 6
##################
ssh-keygen -t rsa -b 4096 -f /home/carranc06/clave.privada -N "" > /dev/null
chgrp carranc06 /home/carranc06/clave.privada
chmod g+r /home/carranc06/clave.privada
mkdir /home/carranc07/.ssh
chgrp carranc07 /home/carranc07/.ssh
mv /home/carranc06/clave.privada.pub /home/carranc07/.ssh/authorized_keys
chown carranc07:carranc07 /home/carranc07/.ssh/authorized_keys

echo "echo -e 'La contraseña del siguiente nivel está almacenada en /etc/carranc_pass/carranc07, pero desgraciadamente solo la puede ver el usuario de nivel 7. No te preocupes, el señor Cangrejo nos ha dejado una clave privada de SSH para poder pasar de nivel.\n'" >> /home/carranc06/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat, ssh, scp, ssh-keygen'" >> /home/carranc06/.bashrc
echo "echo -e 'Páginas de ayuda: https://help.ubuntu.com/community/SSH/OpenSSH/Keys\n'" >> /home/carranc06/.bashrc

##################
# Level 7
##################
for ((i=0; i<70; i++)); do
	password=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)
	echo $password >> /home/carranc07/passwords.old
	echo $password >> /home/carranc07/passwords.new
done
cat /etc/carranc_pass/carranc08 >> /home/carranc07/passwords.new
for ((i=0; i<20; i++)); do
	password=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)
	echo $password >> /home/carranc07/passwords.old
	echo $password >> /home/carranc07/passwords.new
done

echo "echo -e 'La contraseña del siguiente nivel es la única línea añadida del fichero nuevo de contraseñas.\n'" >> /home/carranc07/.bashrc 
echo "echo -e 'Comandos relacionados: ls, cd, cat, diff, sort, uniq, file\n'" >> /home/carranc07/.bashrc

##################
# Level 8
##################
echo "La contraseña del siguiente nivel es `cat /etc/carranc_pass/carranc09`"| tr A-Za-z N-ZA-Mn-za-m > /home/carranc08/data.txt

echo "echo -e 'El Sr. Cangrejo es un amante de la criptografía y le gusta jugar con el cifrado César.\n'" >> /home/carranc08/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat, tr, diff, sort, uniq, file'" >> /home/carranc08/.bashrc
echo "echo -e 'Páginas de ayuda: https://es.wikipedia.org/wiki/ROT13\n'" >> /home/carranc08/.bashrc

##################
# Level 9
##################
echo "La contraseña del siguiente nivel es `cat /etc/carranc_pass/carranc10`" | base64 > /home/carranc09/data.txt

echo "echo -e 'Como el cifrado César te ha resultado muy sencillo, el Sr. Cangrejo ha decidido utilizar la codificación base64.\n'" >> /home/carranc09/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat, file, tr, base64, xxd, md5sum'" >> /home/carranc09/.bashrc
echo "echo -e 'Páginas de ayuda: https://es.wikipedia.org/wiki/Base64\n'" >> /home/carranc09/.bashrc

##################
# Level 10
##################
tar c /etc/carranc_pass/carranc11 | gzip | bzip2 | gzip | xxd > /home/carranc10/password.hex

echo "echo -e 'La contraseña del siguiente nivel encontrarás si logras revertir el volcado hexadecimal de un fichero que ha estado múltiples veces comprimido y agrupado.\n'" | sudo tee -a /home/carranc10/.bashrc > /dev/null
echo "echo -e 'Para trabajar mejor, créate un directorio de trabjo en /tmp y copia en él ese misterioso fichero que nos ha dejado el Sr. Cangrejo.\n'" >> /home/carranc10/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, mkdir, cp, cat, file, tar, xxd, gzip, gunzip, bzip2, bunzip2'" >> /home/carranc10/.bashrc
echo "echo -e 'Páginas de ayuda: https://en.wikipedia.org/wiki/Hex_dump\n'" >> /home/carranc10/.bashrc

##################
# Level 11
##################
mkdir /home/carranc11/passwords

for ((i=0; i<78; i++)); do
    filename="/home/carranc11/passwords/password$(printf '%02d' $i)"
    
    # Crear passwords aleatorios
    password=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32 ; echo)

    # Crear el archivo de contraseña en el directorio correspondiente
    echo "$password" > "$filename"

done

cat /etc/carranc_pass/carranc12 > /home/carranc11/passwords/password55
cat /etc/carranc_pass/carranc12 | md5sum > /home/carranc11/password.md5sum

echo "echo -e 'Cuidado, porque de entre todos los ficheros, sólo uno contiene el password. El Sr. Cangrejo nos ha dejado como pista una tabla hash.\n'" >> /home/carranc11/.bashrc
echo "echo -e 'Comandos relacionados: ls, cd, cat, file, grep, cut, xargs, md5sum, sha256\n'" >> /home/carranc11/.bashrc

##################
# Level 12
##################
echo "La contraseña del siguiente nivel es `cat /etc/carranc_pass/carranc13`" > /home/carranc12/password

echo "echo -e 'La contraseña del siguiente nivel está almacenada en el fichero ~/password, pero el Sr. Cangrejo ha introducido un logout en ~/.bashrc.\n'" | sudo tee -a /home/carranc12/.bashrc > /dev/null
echo "logout" | sudo tee -a /home/carranc12/.bashrc > /dev/null
echo "echo -e 'Comandos relacionados: ls, cd, cat, ssh\n'" >> /home/carranc12/.bashrc

##################
# Level 13
##################
password=$(cat /etc/carranc_pass/carranc14)
groupadd $password
usermod carranc13 -aG $password

echo "echo -e 'Este usuario pertenece a un grupo secudario muy, pero que muy peculiar.\n'" | sudo tee -a /home/carranc13/.bashrc > /dev/null 
echo "echo -e 'Comandos relacionados: ls, cd, cat, file, id\n'" >> /home/carranc13/.bashrc

echo
echo "Contraseñas generadas"
echo "====================="
cat /etc/carranc_pass/carranc*
echo
echo "Para que se apliquen los cambios en el servicio ssh, reinicia el servicio con sudo systemctl restart sshd"
