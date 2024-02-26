Un grupo de exploradores de una raza de seres pandimensionales e hiperinteligentes construyeron **Pensamiento Profundo**, la segunda mejor computadora de todos los tiempos, para obtener la respuesta al sentido de la vida, el universo y todo lo demás. Después de siete millones y medio de años meditando la pregunta, **Pensamiento Profundo** tiene la respuesta.

El **Sr. Tortuga**, un apasionado de la reflexión y del conocimiento, desea averiguar la respuesta a semejente pregunta trascendental, y para ello quiere meterse en las entrañas del supercomputador **Pensamiento Profundo**. Pero el **Sr. Cangrejo**, que cuestiona la capacidad de las máquinas para replicar completamente la complejidad y la profundidad del pensamiento humano, va a evitar a toda costa que el **Sr. Tortuga** averigüe la respuesta.

¿Podrás ayudar al **Sr. Tortuga** a llegar hasta el final y averiguar la respuesta al sentido de la vida?

# Instrucciones

Conéctate por ssh a la dirección IP que te proporcione el profesor para ir pasando los niveles hasta alcanzar la respuesta a la pregunta trascendental. En cada nivel encontrarás la contraseña con la que acceder al siguiente.

Para empezar a jugar, el usuario del nivel 0 es **turtle00** y su contraseña es **turtle00**. Los usuarios de los niveles sucesivos serán *turtleXX* donde XX indica el número de nivel.

# Niveles

## Nivel 0

La contraseña para el nivel 1 la encontrarás en un archivo llamado *readme*

Comandos que te pueden ayudar: `ls, cat, exit`

## Nivel 1

El señor cangrejo ha escondido la contraseña del siguiente nivel en un fichero oculto.

Comandos que te pueden ayudar: `ls, cd, cat`

## Nivel 2

El señor cangrejo es un enamorado de los sistemas de numeración hexadecimal y binario, y ha guardado la contraseña en un fichero que está relacionado doblemente con la primera letra del abecedario.

Comandos que te pueden ayudar: `ls, cd, cat, grep, file`

## Nivel 3

La contraseña del siguiente nivel está almacenada junto a la cadena de texto p@ssW0rd

Comandos que te pueden ayudar: `ls, cd, cat, find, grep, file`

## Nivel 4

La contraseña del siguiente nivel está almacenada en un fichero de 1033 bytes que no es ejecutable.

Comandos que te pueden ayudar: `ls, cd, cat, find, file`

## Nivel 5

La contraseña del siguiente nivel está almacenada en un fichero de 33 bytes cuyo grupo porpietario es turtle05, su usuario propietario es turtle06 y se encuentra ubicado en cualquier lugar del servidor.

**CONSEJO**: estaría bien redireccionar la salida de error a /dev/null

Comandos que te pueden ayudar: `ls, cd, cat, find, grep, file`

## Nivel 6

La contraseña del siguiente nivel es la única línea repetida del fichero donde el Sr. Cangrejo guarda las contraseñas.

Comandos que te pueden ayudar: `ls, cd, cat, uniq, sort, find, grep, file*`

## Nivel 7

La contraseña del siguiente nivel está almacenada en /etc/turtle_pass/turtle08, pero desgraciadamente solo la puede ver el usuario de nivel 7. No te preocupes, el señor Cangrejo nos ha dejado una clave privada de SSH para poder pasar de nivel.

Comandos que te pueden ayudar: `ls, cd, cat, ssh, scp, ssh-keygen`

Páginas de consulta: [OpenSSH Keys](https://help.ubuntu.com/community/SSH/OpenSSH/Keys)

## Nivel 8

La contraseña del siguiente nivel es la única línea añadida del fichero nuevo de contraseñas.

Comandos que te pueden ayudar: `ls, cd, cat, diff, sort, uniq, file`

## Nivel 9

El Sr. Cangrejo es un amante de la criptografía y le gusta jugar con el cifrado César.

Comandos que te pueden ayudar: `ls, cd, cat, tr, diff, sort, uniq, file`

Páginas de consulta: [Cifrado César](https://es.wikipedia.org/wiki/ROT13)

## Nivel 10

Como el cifrado César te ha resultado muy sencillo, el Sr. Cangrejo ha decidido utilizar la codificación base64.

Comandos que te pueden ayudar: `ls, cd, cat, file, tr, base64, xxd, md5sum`

Páginas de consulta: [Codificación base64](https://es.wikipedia.org/wiki/Base64)

## Nivel 11

La contraseña del siguiente nivel encontrarás si logras revertir el volcado hexadecimal de un fichero que ha estado múltiples veces comprimido y agrupado.

Para trabajar mejor, créate un directorio de trabjo en /tmp y copia en él ese misterioso fichero que nos ha dejado el Sr. Cangrejo.

Comandos que te pueden ayudar: `ls, cd, mkdir, cp, cat, file, tar, xxd, gzip, gunzip, bzip2, bunzip2`

Páginas de consulta: [Volcado Hexadecimal](https://en.wikipedia.org/wiki/Hex_dump)

## Nivel 12

Cuidado, porque de entre todos los ficheros, sólo uno contiene el password. El Sr. Cangrejo nos ha dejado como pista el resultado de una función hash.

Comandos que te pueden ayudar: `ls, cd, cat, file, grep, cut, xargs, md5sum, sha256`

Páginas de consulta: [Función Hash](https://es.wikipedia.org/wiki/Funci%C3%B3n_hash), [Md5sum](https://es.wikipedia.org/wiki/Md5sum)

## Nivel 13

La contraseña del siguiente nivel está almacenada en el fichero ~/password, pero el Sr. Cangrejo ha introducido un logout en ~/.bashrc.

Comandos que te pueden ayudar: `ls, cd, cat, ssh`

## Nivel 14

Este usuario pertenece a un grupo secudario muy, pero que muy peculiar.

Comandos que te pueden ayudar: `ls, cd, cat, file, id`

## Nivel 15

La contraseña del siguente nivel está guardada en un fichero del siguiente repositorio:
```
localhost:/opt/git/turtle.git
```
Pero ojo, el Sr. Cangrejo ha creado una nueva versión de ese fichero y ha borrado la contraseña.

Comandos que te pueden ayudar: `ls, cd, cat, git clone, git log, git diff`

## Nivel 16

El Sr. Cangrejo ha dejado en localhost un servicio de red escuchando por un puerto al que le podemos mandar mensajes.

La única pista que nos ha dado es que es un puerto que se encuentra entre el 20000 y el 30000.

Para que nos devuelva la respuesta correcta hemos de pasar un número octal de 3 cifras relacionado con los permisos del fichero cangrejo. 

Comandos que te pueden ayudar: `nmap, nc, ssh, ls`

## Nivel 17

Bravo!!!! Llegaste al final. Ya tienes la respuesta.


