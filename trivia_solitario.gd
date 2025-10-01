extends Control

var preguntas_cultura = [
	{"pregunta":"¿Cuál es la capital de Francia, famosa por la Torre Eiffel?","respuestas":["Madrid","París","Londres","Berlín"],"correcta":1},
	{"pregunta":"¿Quién escribió 'Don Quijote de la Mancha'?","respuestas":["William Shakespeare","Miguel de Cervantes","Ernest Hemingway","Edgar Allan Poe"],"correcta":1},
	{"pregunta":"¿En qué país se originó el Renacimiento?","respuestas":["Italia","Francia","España","Alemania"],"correcta":0},
	{"pregunta":"¿Cuál es la lengua oficial de Brasil?","respuestas":["Portugués","Español","Inglés","Francés"],"correcta":0},
	{"pregunta":"¿Qué civilización construyó las pirámides de Egipto?","respuestas":["Griega","Egipcia","Romana","Maya"],"correcta":1},
	{"pregunta":"¿Quién pintó la Mona Lisa?","respuestas":["Vincent van Gogh","Leonardo da Vinci","Pablo Picasso","Claude Monet"],"correcta":1},
	{"pregunta":"¿Cuál es el río más largo del mundo?","respuestas":["Nilo","Yangtsé","Amazonas","Misisipi"],"correcta":2},
	{"pregunta":"¿Qué país ganó la Copa Mundial de Fútbol en 2018?","respuestas":["Francia","Brasil","Alemania","Argentina"],"correcta":0},
	{"pregunta":"¿Quién escribió 'Romeo y Julieta'?","respuestas":["Miguel de Cervantes","William Shakespeare","Mark Twain","Jane Austen"],"correcta":1},
	{"pregunta":"¿Cuál es la capital de Japón?","respuestas":["Tokio","Beijing","Seúl","Bangkok"],"correcta":0},
	{"pregunta":"¿Cuál es la obra más famosa de Miguel Ángel?","respuestas":["La Capilla Sixtina","La Última Cena","Guernica","El Grito"],"correcta":0},
	{"pregunta":"¿Qué país es conocido como la tierra del sol naciente?","respuestas":["Japón","China","India","Corea del Sur"],"correcta":0},
	{"pregunta":"¿Quién escribió 'Cien años de soledad'?","respuestas":["Gabriel García Márquez","Julio Cortázar","Isabel Allende","Mario Vargas Llosa"],"correcta":0},
	{"pregunta":"¿Cuál es la moneda oficial del Reino Unido?","respuestas":["Libra esterlina","Euro","Dólar","Franco"],"correcta":0},
	{"pregunta":"¿Qué ciudad es famosa por el Carnaval y el Cristo Redentor?","respuestas":["Río de Janeiro","Buenos Aires","Santiago","Lisboa"],"correcta":0},
	{"pregunta":"¿En qué año cayó el Imperio Romano de Occidente?","respuestas":["1492","476 d.C.","1066","395 d.C."],"correcta":1},
	{"pregunta":"¿Qué filósofo griego fue maestro de Alejandro Magno?","respuestas":["Aristóteles","Platón","Sócrates","Epicuro"],"correcta":0},
	{"pregunta":"¿Cuál es la capital de Canadá?","respuestas":["Ottawa","Toronto","Montreal","Vancouver"],"correcta":0},
	{"pregunta":"¿Quién pintó 'La noche estrellada'?","respuestas":["Pablo Picasso","Vincent van Gogh","Leonardo da Vinci","Salvador Dalí"],"correcta":1},
	{"pregunta":"¿Cuál es el continente más grande del mundo?","respuestas":["Asia","África","América","Europa"],"correcta":0},
	{"pregunta":"¿En qué país está el Taj Mahal?","respuestas":["India","China","Pakistán","Japón"],"correcta":0},
	{"pregunta":"¿Cuál es el idioma más hablado en el mundo?","respuestas":["Español","Inglés","Chino mandarín","Hindi"],"correcta":2},
	{"pregunta":"¿Quién fue el primer presidente de Estados Unidos?","respuestas":["Abraham Lincoln","George Washington","Thomas Jefferson","John Adams"],"correcta":1},
	{"pregunta":"¿En qué ciudad se encuentra la estatua de la Libertad?","respuestas":["Nueva York","París","Londres","Washington"],"correcta":0},
	{"pregunta":"¿Quién compuso la Novena Sinfonía?","respuestas":["Mozart","Beethoven","Bach","Chopin"],"correcta":1},
	{"pregunta":"¿Cuál es el país más grande del mundo por superficie?","respuestas":["Estados Unidos","Canadá","China","Rusia"],"correcta":3},
	{"pregunta":"¿Qué escritor es conocido por 'El Principito'?","respuestas":["Antoine de Saint-Exupéry","Gabriel García Márquez","J.K. Rowling","Miguel de Cervantes"],"correcta":0},
	{"pregunta":"¿En qué continente está Egipto?","respuestas":["África","Asia","Europa","América"],"correcta":0},
	{"pregunta":"¿Cuál es el océano más grande del mundo?","respuestas":["Atlántico","Pacífico","Índico","Ártico"],"correcta":1},
	{"pregunta":"¿Quién descubrió América?","respuestas":["Cristóbal Colón","Marco Polo","Américo Vespucio","Fernando Magallanes"],"correcta":0},
	{"pregunta":"¿Qué ciudad es conocida como la ciudad del amor?","respuestas":["Venecia","París","Madrid","Roma"],"correcta":1},
	{"pregunta":"¿Qué país tiene la mayor población mundial?","respuestas":["India","Estados Unidos","China","Brasil"],"correcta":2},
	{"pregunta":"¿Quién pintó 'El Guernica'?","respuestas":["Dalí","Picasso","Velázquez","Goya"],"correcta":1},
	{"pregunta":"¿En qué país nació Ludwig van Beethoven?","respuestas":["Austria","Alemania","Italia","Francia"],"correcta":1},
	{"pregunta":"¿Cuál es el animal símbolo de Australia?","respuestas":["Koala","Canguro","Emú","Dingo"],"correcta":1},
	{"pregunta":"¿Qué país es conocido por la pizza y la pasta?","respuestas":["España","Italia","Francia","México"],"correcta":1},
	{"pregunta":"¿Quién escribió 'La Odisea'?","respuestas":["Homero","Virgilio","Sófocles","Platón"],"correcta":0},
	{"pregunta":"¿Cuál es la capital de Egipto?","respuestas":["El Cairo","Alejandría","Luxor","Giza"],"correcta":0},
	{"pregunta":"¿Qué civilización construyó Machu Picchu?","respuestas":["Maya","Inca","Azteca","Olmeca"],"correcta":1},
	{"pregunta":"¿Quién fue el autor de 'Hamlet'?","respuestas":["Shakespeare","Cervantes","Tolstoi","Kafka"],"correcta":0},
	{"pregunta":"¿Cuál es el país más pequeño del mundo?","respuestas":["Mónaco","San Marino","Ciudad del Vaticano","Liechtenstein"],"correcta":2},
	{"pregunta":"¿Qué festival hindú celebra la victoria de la luz sobre la oscuridad?","respuestas":["Diwali","Holi","Vesak","Ramadán"],"correcta":0},
	{"pregunta":"¿Quién escribió '1984'?","respuestas":["George Orwell","Aldous Huxley","Ray Bradbury","Jules Verne"],"correcta":0},
	{"pregunta":"¿Cuál es la capital de Australia?","respuestas":["Sídney","Melbourne","Canberra","Brisbane"],"correcta":2},
	{"pregunta":"¿En qué país se encuentra la Torre de Pisa?","respuestas":["Italia","Francia","España","Alemania"],"correcta":0},
	{"pregunta":"¿Quién pintó 'La persistencia de la memoria'?","respuestas":["Dalí","Picasso","Monet","Van Gogh"],"correcta":0},
	{"pregunta":"¿Cuál es el idioma oficial de Japón?","respuestas":["Japonés","Coreano","Chino","Inglés"],"correcta":0},
	{"pregunta":"¿En qué año llegó el hombre a la Luna?","respuestas":["1969","1972","1959","1965"],"correcta":0},
	{"pregunta":"¿Quién es el autor de 'Don Juan Tenorio'?","respuestas":["José Zorrilla","Miguel de Unamuno","Federico García Lorca","Benito Pérez Galdós"],"correcta":0},
	{"pregunta":"¿Qué país tiene como símbolo nacional el dragón?","respuestas":["China","Japón","Corea","Tailandia"],"correcta":0}
];

var preguntas_ingenieria = [
	{"pregunta":"¿Qué hace un ingeniero de software?","respuestas":["Desarrolla programas y aplicaciones","Construye puentes","Opera maquinaria pesada","Vende productos tecnológicos"],"correcta":0},
	{"pregunta":"¿Cuál de estos lenguajes se utiliza para programar?","respuestas":["Español","Python","Latín","Francés"],"correcta":1},
	{"pregunta":"¿Qué significa 'HTML'?","respuestas":["HyperText Markup Language","HighText Machine Language","Hyper Transfer Markup Language","Hyperlink Markup Language"],"correcta":0},
	{"pregunta":"¿Cuál es la principal función de un ingeniero civil?","respuestas":["Diseñar y supervisar construcciones","Desarrollar software","Administrar redes informáticas","Investigar en laboratorios"],"correcta":0},
	{"pregunta":"¿Qué hace un ingeniero eléctrico?","respuestas":["Diseña ropa","Diseña sistemas eléctricos y electrónicos","Escribe software","Administra bases de datos"],"correcta":1},
	{"pregunta":"¿Qué es un algoritmo en programación?","respuestas":["Conjunto de pasos para resolver un problema","Un tipo de computadora","Un virus informático","Un lenguaje humano"],"correcta":0},
	{"pregunta":"¿Qué herramienta se utiliza para versionar código?","respuestas":["Word","Excel","Photoshop","Git"],"correcta":3},
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
	{"pregunta":"¿Qué es GitHub?","respuestas":["Plataforma para alojar y colaborar en proyectos de software","Un sistema operativo","Un lenguaje de programación","Un tipo de base de datos"],"correcta":0},
	{"pregunta":"¿Qué se usa para modelar piezas en 3D?","respuestas":["AutoCAD","Excel","Word","Photoshop"],"correcta":0},
	{"pregunta":"¿Qué tipo de ingeniero diseña aviones?","respuestas":["Ingeniero aeronáutico","Ingeniero civil","Ingeniero químico","Ingeniero industrial"],"correcta":0},
	{"pregunta":"¿Qué hace un ingeniero químico?","respuestas":["Diseña procesos y productos químicos","Construye edificios","Opera maquinaria pesada","Desarrolla videojuegos"],"correcta":0},
	{"pregunta":"¿Qué instrumento mide la presión atmosférica?","respuestas":["Barómetro","Termómetro","Amperímetro","Multímetro"],"correcta":0},
	{"pregunta":"¿Qué es una impresora 3D?","respuestas":["Una máquina que crea objetos físicos a partir de modelos digitales","Una computadora portátil","Un servidor web","Un programa de edición"],"correcta":0},
	{"pregunta":"¿Qué tipo de ingeniero trabaja con energías renovables?","respuestas":["Ingeniero ambiental","Ingeniero civil","Ingeniero de datos","Ingeniero mecánico"],"correcta":0},
	{"pregunta":"¿Qué software se usa para crear planos arquitectónicos?","respuestas":["AutoCAD","Excel","Matlab","Word"],"correcta":0},
	{"pregunta":"¿Qué es una variable en programación?","respuestas":["Un espacio para almacenar datos","Un componente mecánico","Un tipo de servidor","Un circuito eléctrico"],"correcta":0},
	{"pregunta":"¿Cuál es la función de un ingeniero industrial?","respuestas":["Optimizar procesos y sistemas productivos","Desarrollar software","Diseñar puentes","Crear videojuegos"],"correcta":0},
	{"pregunta":"¿Qué lenguaje se usa para aplicaciones móviles Android?","respuestas":["Java","Python","PHP","HTML"],"correcta":0},
	{"pregunta":"¿Qué es una base de datos?","respuestas":["Sistema para almacenar y gestionar información","Un programa de diseño","Un tipo de hardware","Un lenguaje de programación"],"correcta":0},
	{"pregunta":"¿Qué es un sensor?","respuestas":["Dispositivo que detecta cambios en su entorno","Un lenguaje de programación","Una computadora portátil","Un tipo de red"],"correcta":0},
	{"pregunta":"¿Qué es la robótica?","respuestas":["Estudio y diseño de robots","Diseño de moda","Producción de alimentos","Gestión de empresas"],"correcta":0},
	{"pregunta":"¿Qué es un microprocesador?","respuestas":["El cerebro de la computadora","Un tipo de impresora","Una aplicación móvil","Un software antivirus"],"correcta":0},
	{"pregunta":"¿Qué es una resistencia eléctrica?","respuestas":["Componente que limita el flujo de corriente","Un tipo de software","Una impresora","Un lenguaje de programación"],"correcta":0},
	{"pregunta":"¿Qué hace un ingeniero en sistemas?","respuestas":["Diseña y gestiona sistemas informáticos","Construye puentes","Opera maquinaria pesada","Diseña circuitos eléctricos"],"correcta":0},
	{"pregunta":"¿Qué lenguaje se usa para el desarrollo de iOS?","respuestas":["Swift","Java","C++","PHP"],"correcta":0},
	{"pregunta":"¿Qué es un plano eléctrico?","respuestas":["Diagrama de un sistema eléctrico","Plano de una casa","Mapa de una ciudad","Diseño de una página web"],"correcta":0},
	{"pregunta":"¿Qué es un compilador?","respuestas":["Programa que traduce código fuente a ejecutable","Un software de diseño","Un servidor web","Un componente mecánico"],"correcta":0},
	{"pregunta":"¿Qué es el Internet de las cosas (IoT)?","respuestas":["Red de dispositivos conectados a Internet","Un tipo de base de datos","Un lenguaje de programación","Un software de diseño"],"correcta":0},
	{"pregunta":"¿Qué hace un ingeniero de hardware?","respuestas":["Diseña componentes físicos de computadoras","Desarrolla software","Gestiona redes","Opera maquinaria pesada"],"correcta":0},
	{"pregunta":"¿Qué instrumento mide la temperatura?","respuestas":["Termómetro","Barómetro","Multímetro","Amperímetro"],"correcta":0},
	{"pregunta":"¿Qué es un sistema operativo?","respuestas":["Software que administra recursos del computador","Un componente mecánico","Un lenguaje de programación","Un circuito eléctrico"],"correcta":0},
	{"pregunta":"¿Qué hace un ingeniero de redes?","respuestas":["Diseña, configura y mantiene redes informáticas","Construye puentes","Desarrolla software","Opera maquinaria pesada"],"correcta":0},
	{"pregunta":"¿Qué es un PLC?","respuestas":["Controlador lógico programable","Un tipo de procesador","Un software de diseño","Un lenguaje de programación"],"correcta":0},
	{"pregunta":"¿Qué es una interfaz gráfica de usuario (GUI)?","respuestas":["Medio visual para interactuar con software","Un componente mecánico","Un tipo de servidor","Un circuito eléctrico"],"correcta":0},
	{"pregunta":"¿Qué es la ingeniería genética?","respuestas":["Modificación de genes de organismos vivos","Diseño de circuitos eléctricos","Construcción de puentes","Desarrollo de software"],"correcta":0},
	{"pregunta":"¿Qué lenguaje se usa para páginas web?","respuestas":["HTML","Python","C++","Java"],"correcta":0},
	{"pregunta":"¿Qué hace un ingeniero ambiental?","respuestas":["Trabaja en la protección del medio ambiente","Desarrolla software","Construye puentes","Opera maquinaria pesada"],"correcta":0}
];

var preguntas_restantes = []
var pregunta_actual = {}
var puntaje = 0
var categoria_seleccionada = ""
var puntaje_maximo = 0
var total_preguntas = 20

func _ready():
	# Estilo profesional en la UI
	$Label.text = "🧠 Selecciona la categoría para comenzar"
	$Label.add_theme_color_override("font_color", Color(0.2, 0.2, 0.7))
	$Label.add_theme_font_size_override("font_size", 28)
	$Mensaje.text = ""
	$Mensaje.add_theme_color_override("font_color", Color(0.1, 0.5, 0.1))
	$Mensaje.add_theme_font_size_override("font_size", 22)

	$Boton0.text = "Cultura General"
	$Boton1.text = "Ingeniería"
	$Boton2.hide()
	$Boton3.hide()
	$Boton4.text = "Salir"
	$Boton5.text = "Intentar de nuevo"
	$Boton5.hide()

	$Boton0.connect("pressed", Callable(self, "_on_Boton0_pressed"))
	$Boton1.connect("pressed", Callable(self, "_on_Boton1_pressed"))
	$Boton2.connect("pressed", Callable(self, "_on_Boton2_pressed"))
	$Boton3.connect("pressed", Callable(self, "_on_Boton3_pressed"))
	$Boton4.connect("pressed", Callable(self, "_on_Boton4_pressed"))
	$Boton5.connect("pressed", Callable(self, "_on_Boton5_pressed"))

	# Cargar puntaje máximo guardado
	var load = FileAccess.open("user://trivia_solitario.save", FileAccess.READ)
	if load:
		if load.get_length() > 0:
			puntaje_maximo = load.get_32()
		load.close()

func reproducir_sonido_click():
	$AudioClick.play()

func _on_Boton0_pressed():
	reproducir_sonido_click()
	if categoria_seleccionada == "":
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
	get_tree().change_scene_to_file("res://trivia.tscn")

func _on_Boton5_pressed():
	reproducir_sonido_click()
	get_tree().reload_current_scene()

func iniciar_juego(categoria):
	categoria_seleccionada = categoria
	var fuente = []
	if categoria == "cultura":
		fuente = preguntas_cultura.duplicate()
	elif categoria == "ingenieria":
		fuente = preguntas_ingenieria.duplicate()
	fuente.shuffle()
	preguntas_restantes = fuente.slice(0, total_preguntas)
	puntaje = 0
	$Boton2.show()
	$Boton3.show()
	$Boton0.hide()
	$Boton1.hide()
	$Boton5.hide()
	mostrar_pregunta_aleatoria()

func mostrar_pregunta_aleatoria():
	if preguntas_restantes.size() == 0:
		mostrar_resultado()
		return
	pregunta_actual = preguntas_restantes.pop_front()
	$Label.text = "Pregunta %d/%d:\n%s" % [total_preguntas - preguntas_restantes.size(), total_preguntas, pregunta_actual["pregunta"]]
	for i in range(4):
		var boton = get_node("Boton%d" % i)
		if i < pregunta_actual["respuestas"].size():
			boton.text = pregunta_actual["respuestas"][i]
			boton.disabled = false
			boton.show()
		else:
			boton.hide()
	$Mensaje.text = ""

func verificar_respuesta(indice):
	for i in range(4):
		get_node("Boton%d" % i).disabled = true
	if indice == pregunta_actual["correcta"]:
		puntaje += 1
		$Mensaje.text = "✅ ¡Correcto!"
	else:
		$Mensaje.text = "❌ Incorrecto"
	await get_tree().create_timer(1.2).timeout
	mostrar_pregunta_aleatoria()

func mostrar_resultado():
	if puntaje > puntaje_maximo:
		puntaje_maximo = puntaje
		# Guardar puntaje máximo
		var save = FileAccess.open("user://trivia_solitario.save", FileAccess.WRITE)
		if save:
			save.store_32(puntaje_maximo)
			save.close()
	var porcentaje = (float(puntaje) / float(total_preguntas)) * 100
	var mensaje_evaluacion = ""
	if porcentaje >= 80:
		mensaje_evaluacion = "🌟 ¡Excelente trabajo!"
	elif porcentaje >= 60:
		mensaje_evaluacion = "👍 ¡Bien hecho!"
	elif porcentaje >= 40:
		mensaje_evaluacion = "🔄 Puedes mejorar"
	else:
		mensaje_evaluacion = "📚 Necesitas estudiar más"
	$Label.text = "🎉 ¡Trivia terminada!\n%s\nRespuestas correctas: %d de %d\nPorcentaje: %d%%\n🏆 Mejor puntaje: %d" % [mensaje_evaluacion, puntaje, total_preguntas, int(porcentaje), puntaje_maximo]
	$Boton0.hide()
	$Boton1.hide()
	$Boton2.hide()
	$Boton3.hide()
	$Boton4.show()
	$Boton5.show()
	$Mensaje.text = ""
