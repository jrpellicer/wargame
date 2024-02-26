import socket
import threading

class Servidor:
    def __init__(self, host="localhost", port=25600):
        self.clientes = []
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.bind((host, port))
        self.sock.listen(20)
        #print("Servidor escuchando en el puerto", port)
        
        # Thread para aceptar conexiones
        aceptar_thread = threading.Thread(target=self.aceptar_conexiones)
        aceptar_thread.start()

    def aceptar_conexiones(self):
        while True:
            conn, addr = self.sock.accept()
            #print("Conexión establecida con", addr)
            conn_thread = threading.Thread(target=self.procesar_conexion, args=(conn,))
            conn_thread.start()

    def procesar_conexion(self, conn):
        self.clientes.append(conn)
        while True:
            try:
                data = conn.recv(1024)
                if not data:
                    break
                mensaje = data.decode('utf-8').strip()
                #print("Mensaje recibido:", mensaje)
                if mensaje == "640":
                    with open('/etc/turtle_pass/turtle17', 'r') as f:
                        contenido = f.read()
                    mensaje_salida = "Password: {}\nPulsa Intro para salir\n".format(contenido)
                    conn.sendall(mensaje_salida.encode('utf-8'))
                    break
                else:
                    conn.sendall("Lo siento, no es lo que esperaba.\n".encode('utf-8'))
            except Exception as e:
                #print("Error:", e)
                break
        conn.close()
        self.clientes.remove(conn)

# Crear instancia del servidor
servidor = Servidor()
