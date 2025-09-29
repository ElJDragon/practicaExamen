extends Control

# Preguntas por categoría
var preguntas_cultura = [
	{"pregunta":"¿Cuál es la capital de Francia, famosa por la Torre Eiffel?","respuestas":["París","Madrid","Londres","Berlín"],"correcta":0},
	{"pregunta":"¿Quién escribió 'Don Quijote de la Mancha'?","respuestas":["Miguel de Cervantes","William Shakespeare","Ernest Hemingway","Edgar Allan Poe"],"correcta":0},
	{"pregunta":"¿En qué país se originó el Renacimiento?","respuestas":["Italia","Francia","España","Alemania"],"correcta":0},
	{"pregunta":"¿Cuál es la lengua oficial de Brasil?","respuestas":["Portugués","Español","Inglés","Francés"],"correcta":0},
	{"pregunta":"¿Qué civilización construyó las pirámides de Egipto?","respuestas":["Egipcia","Griega","Romana","Maya"],"correcta":0},
	{"pregunta":"¿Quién pintó la Mona Lisa?","respuestas":["Leonardo da Vinci","Vincent van Gogh","Pablo Picasso","Claude Monet"],"correcta":0},
	{"pregunta":"¿Cuál es el río más largo del mundo?","respuestas":["Nilo","Amazonas","Yangtsé","Misisipi"],"correcta":1},
	{"pregunta":"¿Qué país ganó la Copa Mundial de Fútbol en 2018?","respuestas":["Francia","Brasil","Alemania","Argentina"],"correcta":0},
	{"pregunta":"¿Quién escribió 'Romeo y Julieta'?","respuestas":["William Shakespeare","Miguel de Cervantes","Mark Twain","Jane Austen"],"correcta":0},
	{"pregunta":"¿Cuál es la capital de Japón?","respuestas":["Tokio","Beijing","Seúl","Bangkok"],"correcta":0},
	{"pregunta":"¿Cuál es la obra más famosa de Miguel Ángel?","respuestas":["La Capilla Sixtina","La Última Cena","Guernica","El Grito"],"correcta":0},
	{"pregunta":"¿Qué país es conocido como la tierra del sol naciente?","respuestas":["Japón","China","India","Corea del Sur"],"correcta":0},
	{"pregunta":"¿Quién escribió 'Cien años de soledad'?","respuestas":["Gabriel García Márquez","Julio Cortázar","Isabel Allende","Mario Vargas Llosa"],"correcta":0},
	{"pregunta":"¿Cuál es la moneda oficial del Reino Unido?","respuestas":["Libra esterlina","Euro","Dólar","Franco"],"correcta":0},
	{"pregunta":"¿Qué ciudad es famosa por el Carnaval y el Cristo Redentor?","respuestas":["Río de Janeiro","Buenos Aires","Santiago","Lisboa"],"correcta":0},
	{"pregunta":"¿En qué año cayó el Imperio Romano de Occidente?","respuestas":["476 d.C.","1492","1066","395 d.C."],"correcta":0},
	{"pregunta":"¿Qué filósofo griego fue maestro de Alejandro Magno?","respuestas":["Aristóteles","Platón","Sócrates","Epicuro"],"correcta":0},
	{"pregunta":"¿Cuál es la capital de Canadá?","respuestas":["Ottawa","Toronto","Montreal","Vancouver"],"correcta":0},
	{"pregunta":"¿Quién pintó 'La noche estrellada'?","respuestas":["Vincent van Gogh","Pablo Picasso","Leonardo da Vinci","Salvador Dalí"],"correcta":0},
	{"pregunta":"¿Cuál es el continente más grande del mundo?","respuestas":["Asia","África","América","Europa"],"correcta":0}
];

var preguntas_ingenieria = [
	{"pregunta":"¿Qué hace un ingeniero de software?","respuestas":["Desarrolla programas y aplicaciones","Construye puentes","Opera maquinaria pesada","Vende productos tecnológicos"],"correcta":0},
	{"pregunta":"¿Cuál de estos lenguajes se utiliza para programar?","respuestas":["Python","Español","Latín","Francés"],"correcta":0},
	{"pregunta":"¿Qué significa 'HTML'?","respuestas":["HyperText Markup Language","HighText Machine Language","Hyper Transfer Markup Language","Hyperlink Markup Language"],"correcta":0},
	{"pregunta":"¿Cuál es la principal función de un ingeniero civil?","respuestas":["Diseñar y supervisar construcciones","Desarrollar software","Administrar redes informáticas","Investigar en laboratorios"],"correcta":0},
	{"pregunta":"¿Qué hace un ingeniero eléctrico?","respuestas":["Diseña sistemas eléctricos y electrónicos","Diseña ropa","Escribe software","Administra bases de datos"],"correcta":0},
	{"pregunta":"¿Qué es un algoritmo en programación?","respuestas":["Conjunto de pasos para resolver un problema","Un tipo de computadora","Un virus informático","Un lenguaje humano"],"correcta":0},
	{"pregunta":"¿Qué herramienta se utiliza para versionar código?","respuestas":["Git","Word","Excel","Photoshop"],"correcta":0},
	{"pregunta":"¿Qué es un circuito eléctrico?","respuestas":["Camino por el que circula la corriente eléctrica","Un programa informático","Un puente de carretera","Un componente mecánico"],"correcta":0},
	{"pregunta":"¿Qué lenguaje se usa principalmente para desarrollo web frontend?","respuestas":["JavaScript","Python","C++","Java"],"correcta":0},
	{"pregunta":"¿Cuál es la función de un ingeniero mecánico?","respuestas":["Diseñar y mantener sistemas mecánicos","Programar aplicaciones móviles","Gestionar bases de datos","Supervisar redes eléctricas"],"correcta":0},
	{"pregunta":"¿Qué es la Inteligencia Artificial?","respuestas":["Simulación de la inteligencia humana en máquinas","Un lenguaje de programación","Un sistema operativo","Una red de computadoras"],"correcta":0},
	{"pregunta":"¿Qué representa un diagrama de flujo?","respuestas":["El flujo de pasos de un proceso o algoritmo","El plano de un edificio","El diseño de un circuito eléctrico","La jerarquía de una empresa"],"correcta":0},
	{"pregunta":"¿Qué hace un ingeniero de datos?","respuestas":["Diseña y mantiene sistemas de gestión de datos","Construye puentes","Diseña circuitos eléctricos","Administra la logística de una empresa"],"correcta":0},
	{"pregunta":"¿Qué significa 'API'?","respuestas":["Application Programming Interface","Applied Program Instruction","Automatic Processing Interface","Active Protocol Integration"],"correcta":0},
	{"pregunta":"¿Qué es un servidor en informática?","respuestas":["Computadora que proporciona servicios a otras","Un tipo de software antivirus","Un lenguaje de programación","Un procesador"],"correcta":0},
	{"pregunta":"¿Qué hace un ingeniero en telecomunicaciones?","respuestas":["Diseña y gestiona redes de comunicación","Desarrolla videojuegos","Construye maquinaria","Diseña moda"],"correcta":0},
	{"pregunta":"¿Qué es el 'backend' en desarrollo web?","respuestas":["La parte del servidor y lógica de la aplicación","El diseño visual de una página web","La red de computadoras","El hardware de un servidor"],"correcta":0},
	{"pregunta":"¿Cuál es el lenguaje más usado en inteligencia artificial y machine learning?","respuestas":["Python","JavaScript","PHP","HTML"],"correcta":0},
	{"pregunta":"¿Qué es la nube (cloud computing)?","respuestas":["Almacenamiento y servicios por internet","Un disco duro físico","Un tipo de computadora portátil","Un lenguaje de programación"],"correcta":0},
	{"pregunta":"¿Qué es GitHub?","respuestas":["Plataforma para alojar y colaborar en proyectos de software","Un sistema operativo","Un lenguaje de programación","Un tipo de base de datos"],"correcta":0}
];


var preguntas_restantes = []
var pregunta_actual = {}
var puntaje = 0
var categoria_seleccionada = ""

func _ready():
	# Mostrar la selección de categoría
	$Label.text = "Selecciona categoría"
	$Boton0.text = "Preguntas de Cultura"
	$Boton1.text = "Preguntas de Ingeniería"
	$Boton2.hide()
	$Boton3.hide()
	$Mensaje.text = ""
	$Boton4.text = "Salir"

	# Conectar señales de botones por código
	$Boton0.connect("pressed", Callable(self, "_on_Boton0_pressed"))
	$Boton1.connect("pressed", Callable(self, "_on_Boton1_pressed"))
	$Boton2.connect("pressed", Callable(self, "_on_Boton2_pressed"))
	$Boton3.connect("pressed", Callable(self, "_on_Boton3_pressed"))
	$Boton4.connect("pressed", Callable(self, "_on_Boton4_pressed"))


func reproducir_sonido_click():
	$AudioClick.play()
func _on_Boton0_pressed():
	print("hola")
	reproducir_sonido_click()
	if categoria_seleccionada == "":
		print("hola")
		iniciar_juego("cultura")
	else:
		verificar_respuesta(0)

func _on_Boton1_pressed():
	reproducir_sonido_click()
	if categoria_seleccionada == "":
		iniciar_juego("ingenieria")
	else:
		verificar_respuesta(1)

func _on_Boton2_pressed():
	reproducir_sonido_click()
	verificar_respuesta(2)

func _on_Boton3_pressed():
	reproducir_sonido_click()
	verificar_respuesta(3)
func _on_Boton4_pressed():
	reproducir_sonido_click()
	# Regresar al mundo principal manteniendo la posición del mono
	get_tree().change_scene_to_file("res://mundo.tscn")

func iniciar_juego(categoria):
	categoria_seleccionada = categoria
	if categoria == "cultura":
		preguntas_restantes = preguntas_cultura.duplicate()
	elif categoria == "ingenieria":
		preguntas_restantes = preguntas_ingenieria.duplicate()

	puntaje = 0
	$Boton2.show()
	$Boton3.show()
	mostrar_pregunta_aleatoria()

func mostrar_pregunta_aleatoria():
	if preguntas_restantes.size() == 0:
		mostrar_resultado()
		return
	pregunta_actual = preguntas_restantes.pick_random()
	preguntas_restantes.erase(pregunta_actual)
	$Label.text = pregunta_actual["pregunta"]

	for i in range(4):
		if i < pregunta_actual["respuestas"].size():
			get_node("Boton%d" % i).text = pregunta_actual["respuestas"][i]
			get_node("Boton%d" % i).disabled = false

	$Mensaje.text = ""

func verificar_respuesta(indice):
	for i in range(4):
		get_node("Boton%d" % i).disabled = true
	if indice == pregunta_actual["correcta"]:
		puntaje += 1
		$Mensaje.text = "¡Correcto!"
	else:
		$Mensaje.text = "Incorrecto"

	await get_tree().create_timer(1.2).timeout
	mostrar_pregunta_aleatoria()

func mostrar_resultado():
	var total_preguntas = 20  # Total de preguntas disponibles por categoría
	var porcentaje = (float(puntaje) / float(total_preguntas)) * 100
	var mensaje_evaluacion = ""
	
	if porcentaje >= 80:
		mensaje_evaluacion = "¡Excelente trabajo!"
	elif porcentaje >= 60:
		mensaje_evaluacion = "¡Bien hecho!"
	elif porcentaje >= 40:
		mensaje_evaluacion = "Puedes mejorar"
	else:
		mensaje_evaluacion = "Necesitas estudiar más"
	
	$Label.text = "¡Trivia terminada!\n" + mensaje_evaluacion + "\nRespuestas correctas: %d de %d\nPorcentaje: %d%%" % [puntaje, total_preguntas, int(porcentaje)]
	
	$Boton0.hide()
	$Boton1.hide()
	$Boton2.hide()
	$Boton3.hide()
	$Mensaje.text = ""
	
	# Esperar 3 segundos y luego regresar al mundo principal
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://mundo.tscn")
