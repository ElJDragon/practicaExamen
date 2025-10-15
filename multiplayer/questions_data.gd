# preguntas por categoria - ejemplo
# Añade más preguntas hasta alcanzar 100+ por categoría según necesites.
# Estructura: {"pregunta":"...","respuestas":[..],"correcta":index}

const QUESTIONS := {
	"programacion": [
		{"pregunta":"¿Qué significa 'OOP'?","respuestas":["Programación orientada a objetos","Operación de procesos","Open Office Project","Ordenes por Protocolo"],"correcta":0},
		{"pregunta":"¿Cuál es un lenguaje tipado dinámicamente?","respuestas":["Python","Java","C++","C#"],"correcta":0},
		{"pregunta":"¿Qué estructura de datos usa FIFO?","respuestas":["Cola","Pila","Árbol","Grafo"],"correcta":0},
		{"pregunta":"¿Qué es un 'commit' en git?","respuestas":["Registrar cambios en el historial","Eliminar rama","Crear carpeta","Subir archivo"],"correcta":0},
		{"pregunta":"¿Qué hace la sentencia 'return' en una función?","respuestas":["Devuelve un valor y termina la función","Imprime texto","Crea una variable","Inicia un bucle"],"correcta":0},
		{"pregunta":"¿Qué es un algoritmo de ordenamiento estable?","respuestas":["Mantiene el orden relativo de elementos iguales","Cambia el orden de elementos iguales","Ordena solo por claves","No modifica datos"],"correcta":0},
		{"pregunta":"¿Cuál es la complejidad promedio de quicksort?","respuestas":["O(n log n)","O(n^2)","O(n)","O(log n)"],"correcta":0},
		{"pregunta":"¿Qué patrón crea una única instancia de una clase?","respuestas":["Singleton","Factory","Observer","Decorator"],"correcta":0},
		{"pregunta":"¿Qué es una 'closure' en programación?","respuestas":["Función que captura su entorno","Clase abstracta","Tipo de dato","Operador lógico"],"correcta":0},
		{"pregunta":"¿Qué tipo de prueba verifica un componente aislado?","respuestas":["Unitarias","Integración","E2E","De carga"],"correcta":0},
		{"pregunta":"¿Qué es TDD?","respuestas":["Desarrollo guiado por pruebas","Desarrollo tradicional","Técnica de depuración","Transacción distribuida"],"correcta":0},
		{"pregunta":"¿Qué keyword crea una clase en Python?","respuestas":["class","def","struct","type"],"correcta":0},
		{"pregunta":"¿Qué es un 'merge' en git?","respuestas":["Unir dos ramas","Eliminar rama","Subir código","Crear repositorio"],"correcta":0},
		{"pregunta":"¿Qué significa 'HTTP'?","respuestas":["HyperText Transfer Protocol","High Transfer Text Protocol","Hyperlink Transfer Protocol","HyperText Translate Protocol"],"correcta":0},
		{"pregunta":"¿Qué es una API RESTful?","respuestas":["Interfaz web que usa HTTP y recursos","Base de datos relacional","Librería UI","Protocolo de correo"],"correcta":0},
		{"pregunta":"¿Cuál es el propósito de un 'router' en una aplicación web?","respuestas":["Dirigir rutas a controladores","Almacenar datos","Renderizar estilos","Gestionar bases de datos"],"correcta":0},
		{"pregunta":"¿Qué es un 'stack overflow'?","respuestas":["Desbordamiento de pila por recursión infinita","Sobrecarga de servidor","Tipo de dato de la pila","Error de compilación"],"correcta":0},
		{"pregunta":"¿Qué es una variable inmutable?","respuestas":["No puede cambiar su valor después de creada","Se puede cambiar siempre","Solo existe en tiempo de compilación","Es pública por defecto"],"correcta":0},
		{"pregunta":"¿Qué es un 'garbage collector'?","respuestas":["Mecanismo que libera memoria no usada","Herramienta para limpiar código","Depurador automático","Servidor de archivos"],"correcta":0},
		{"pregunta":"¿Qué significa 'CI/CD'?","respuestas":["Integración y entrega continua","Ciclo de desarrollo","Compilación incremental","Control de versiones"],"correcta":0}
	],
	"redes": [
		{"pregunta":"¿Qué significa IP?","respuestas":["Internet Protocol","Internal Process","Internet Port","Interchange Protocol"],"correcta":0},
		{"pregunta":"¿Qué hace un router?","respuestas":["Encaminar paquetes entre redes","Almacenar archivos","Renderizar páginas web","Crear direcciones IP"],"correcta":0},
		{"pregunta":"¿Qué es DHCP?","respuestas":["Protocolo que asigna IPs automáticamente","Protocolo de correo","Protocolo de base de datos","Protocolo de seguridad"],"correcta":0},
		{"pregunta":"¿Qué puerto usa HTTP por defecto?","respuestas":["80","443","22","21"],"correcta":0},
		{"pregunta":"¿Qué es una máscara de subred?","respuestas":["Definir la porción de red en una IP","Encriptar datos","Asignar hostname","Monitorizar tráfico"],"correcta":0},
		{"pregunta":"¿Qué es NAT?","respuestas":["Traducción de direcciones de red","Nuevo protocolo","Herramienta de backup","Servicio de DNS"],"correcta":0},
		{"pregunta":"¿Qué protocolo se usa para correo seguro?","respuestas":["IMAPS/SMTPS","HTTP","FTP","Telnet"],"correcta":0},
		{"pregunta":"¿Qué es ARP?","respuestas":["Resuelve direcciones IP a MAC","Asigna IPs dinámicas","Mide latencia","Protocolo de encriptación"],"correcta":0},
		{"pregunta":"¿Qué es una VLAN?","respuestas":["Red lógica separada dentro de una física","Tipo de router","Unidad de almacenamiento","Balanceador de carga"],"correcta":0},
		{"pregunta":"¿Qué significa 'ping'?","respuestas":["Comprobar conectividad y latencia","Transferir archivos","Instalar paquetes","Monitorear CPU"],"correcta":0},
		{"pregunta":"¿Qué es TCP?","respuestas":["Protocolo orientado a conexión","Protocolo sin conexión","Lenguaje de programación","Servicio web"],"correcta":0},
		{"pregunta":"¿Qué es UDP?","respuestas":["Protocolo sin conexión, rápido","Protocolo seguro","Servidor de archivos","Protocolo de correo"],"correcta":0},
		{"pregunta":"¿Qué es SSL/TLS?","respuestas":["Capa de seguridad para comunicaciones","Lenguaje de redes","Tipo de hardware","Protocolo de routing"],"correcta":0},
		{"pregunta":"¿Qué es un switch?","respuestas":["Dispositivo que conecta dispositivos en una LAN","Servidor remoto","Programa antivirus","Cliente ligero"],"correcta":0},
		{"pregunta":"¿Qué significa 'latencia'?","respuestas":["Retraso en la transmisión de datos","Ancho de banda","Tasa de error","Velocidad de CPU"],"correcta":0},
		{"pregunta":"¿Qué es un firewall?","respuestas":["Dispositivo o software que controla tráfico","Tipo de cable","Protocolo de red","Configuración de DNS"],"correcta":0},
		{"pregunta":"¿Qué es QoS?","respuestas":["Calidad de servicio para priorizar tráfico","Consulta de servidor","Herramienta de backup","Protocolo de email"],"correcta":0},
		{"pregunta":"¿Qué es una dirección MAC?","respuestas":["Identificador físico de un dispositivo de red","IP dinámica","Nombre de host","Clave de encriptación"],"correcta":0},
		{"pregunta":"¿Qué es SNMP?","respuestas":["Protocolo para monitoreo de dispositivos","Base de datos","Protocolo de transferencia","Lenguaje de scripting"],"correcta":0}
	],
	"bases_de_datos": [
		{"pregunta":"¿Qué significa SQL?","respuestas":["Structured Query Language","Simple Query Language","Secure Query Language","Sequential Query Language"],"correcta":0},
		{"pregunta":"¿Qué es una clave primaria?","respuestas":["Identificador único de una fila","Contraseña de usuario","Índice secundario","Vista de base de datos"],"correcta":0},
		{"pregunta":"¿Qué es normalización?","respuestas":["Proceso para reducir redundancia en tablas","Respaldar datos","Actualizar índices","Optimizar consultas"],"correcta":0},
		{"pregunta":"¿Qué es un índice?","respuestas":["Estructura para acelerar consultas","Tipo de dato","Tabla temporal","Backup"],"correcta":0},
		{"pregunta":"¿Qué es ACID?","respuestas":["Propiedades que garantizan transacciones confiables","Tipo de base de datos","Lenguaje de consulta","Sistema de backup"],"correcta":0},
		{"pregunta":"¿Qué es una vista?","respuestas":["Consulta almacenada como objeto lógico","Tabla física","Índice","Relación"],"correcta":0},
		{"pregunta":"¿Qué es denormalización?","respuestas":["Introducir redundancia para rendimiento","Eliminar datos","Compactar tablas","Crear índices"],"correcta":0},
		{"pregunta":"¿Qué es NoSQL?","respuestas":["Bases de datos no relacionales","Lenguaje de scripting","Servidor web","Sistema operativo"],"correcta":0},
		{"pregunta":"¿Qué es una transacción?","respuestas":["Grupo de operaciones atómicas","Copia de seguridad","Índice","Consulta"],"correcta":0},
		{"pregunta":"¿Qué es replicación?","respuestas":["Copiar datos entre servidores para redundancia","Normalizar datos","Crear índices","Optimizar consultas"],"correcta":0}
	]
}

# Helper para obtener preguntas aleatorias por categoría
func get_random_questions(categoria:String, count:int) -> Array:
	var list = []
	if QUESTIONS.has(categoria):
		list = QUESTIONS[categoria].duplicate()
		list.shuffle()
		return list.slice(0, min(count, list.size()))
	else:
		return []
