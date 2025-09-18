extends Control

var preguntas = [
	{
		"pregunta": "¿Qué hace un ingeniero de software?",
		"respuestas": [
			"Desarrolla programas y aplicaciones",
			"Construye puentes",
			"Opera maquinaria pesada",
			"Vende productos en una tienda"
		],
		"correcta": 0
	},
	{
		"pregunta": "¿Cuál de estos lenguajes se usa para programar?",
		"respuestas": [
			"Español",
			"Python",
			"Latín",
			"Francés"
		],
		"correcta": 1
	},
	{
		"pregunta": "¿Qué dispositivo es esencial para programar?",
		"respuestas": [
			"Refrigeradora",
			"Televisor",
			"Computadora",
			"Microondas"
		],
		"correcta": 2
	},
	{
		"pregunta": "¿Qué es una aplicación móvil?",
		"respuestas": [
			"Un libro de papel",
			"Una bicicleta",
			"Un tipo de comida",
			"Un programa que funciona en celulares"
		],
		"correcta": 3
	},
	{
		"pregunta": "¿Para qué sirve Internet en la ingeniería de software?",
		"respuestas": [
			"Para cocinar",
			"Para buscar información y colaborar",
			"Para pintar paredes",
			"Para hacer ejercicio físico"
		],
		"correcta": 1
	},
	{
		"pregunta": "¿Qué es un videojuego?",
		"respuestas": [
			"Un deporte tradicional",
			"Un instrumento musical",
			"Un programa interactivo para entretener",
			"Una receta de cocina"
		],
		"correcta": 2
	},
	{
		"pregunta": "¿Qué habilidad es importante para un ingeniero de software?",
		"respuestas": [
			"Saltar muy alto",
			"Cantar ópera",
			"Conducir camiones",
			"Resolver problemas"
		],
		"correcta": 3
	},
	{
		"pregunta": "¿Qué puedes crear estudiando ingeniería de software?",
		"respuestas": [
			"Zapatos",
			"Apps, videojuegos y páginas web",
			"Comida rápida",
			"Ropa de moda"
		],
		"correcta": 1
	},
	{
		"pregunta": "¿Qué es la inteligencia artificial?",
		"respuestas": [
			"Un tipo de deporte",
			"Un animal exótico",
			"Programas que aprenden y resuelven tareas",
			"Un estilo de baile"
		],
		"correcta": 2
	},
	{
		"pregunta": "¿Por qué es importante la tecnología en la vida diaria?",
		"respuestas": [
			"Sirve solo para jugar",
			"No tiene utilidad",
			"Es solo para adultos",
			"Facilita comunicación y acceso a información"
		],
		"correcta": 3
	},
	{
		"pregunta": "¿Qué redes sociales usan programación para funcionar?",
		"respuestas": [
			"Solo los periódicos",
			"Instagram, TikTok y WhatsApp",
			"Únicamente la radio",
			"Solo las cartas escritas"
		],
		"correcta": 1
	},
	{
		"pregunta": "¿Cuánto puede ganar un ingeniero de software?",
		"respuestas": [
			"Muy poco dinero",
			"Solo trabajos gratis",
			"Salarios muy competitivos y altos",
			"No hay oportunidades laborales"
		],
		"correcta": 2
	},
	{
		"pregunta": "¿Qué empresas famosas fueron creadas por ingenieros de software?",
		"respuestas": [
			"McDonalds y Burger King",
			"Solo tiendas de ropa",
			"Solo bancos tradicionales",
			"Google, Facebook, Microsoft y Apple"
		],
		"correcta": 3
	},
	{
		"pregunta": "¿Desde qué edad se puede empezar a programar?",
		"respuestas": [
			"Desde la adolescencia, ¡incluso ahora!",
			"Solo después de los 40 años",
			"Únicamente en la universidad",
			"Solo si tienes un título de matemáticas"
		],
		"correcta": 0
	},
	{
		"pregunta": "¿Qué aplicaciones usan los jóvenes que fueron creadas por programadores?",
		"respuestas": [
			"Solo calculadoras básicas",
			"Spotify, Netflix, YouTube y Zoom",
			"Únicamente procesadores de texto",
			"Solo programas de contabilidad"
		],
		"correcta": 1
	},
	{
		"pregunta": "¿Puedes trabajar como ingeniero de software desde casa?",
		"respuestas": [
			"No, siempre en oficina",
			"Solo los fines de semana",
			"Sí, es una profesión muy flexible",
			"Solo durante vacaciones"
		],
		"correcta": 2
	},
	{
		"pregunta": "¿Qué problemas del mundo real puede resolver un ingeniero de software?",
		"respuestas": [
			"Solo arreglar electrodomésticos",
			"Solo pintar casas",
			"Solo reparar automóviles",
			"Apps para salud, educación y medio ambiente"
		],
		"correcta": 3
	},
	{
		"pregunta": "¿Cómo funciona una plataforma de delivery como Uber Eats?",
		"respuestas": [
			"Solo por teléfono fijo",
			"Apps programadas que conectan clientes",
			"Solo con cartas escritas",
			"Solo visitando restaurantes"
		],
		"correcta": 1
	},
	{
		"pregunta": "¿Qué necesitas para crear tu propia startup tecnológica?",
		"respuestas": [
			"Solo mucho dinero",
			"Solo contactos familiares",
			"Ideas innovadoras y saber programar",
			"Solo suerte"
		],
		"correcta": 2
	},
	{
		"pregunta": "¿Qué tienen en común Mark Zuckerberg, Bill Gates y Steve Jobs?",
		"respuestas": [
			"Todos fueron atletas profesionales",
			"Solo trabajaron en restaurantes",
			"Solo estudiaron medicina",
			"Estudiaron programación y crearon empresas tech"
		],
		"correcta": 3
	},
	{
		"pregunta": "¿Qué es un desarrollador web?",
		"respuestas": [
			"Crea páginas web y sitios de internet",
			"Vende páginas de libros",
			"Limpia computadoras",
			"Entrega periódicos"
		],
		"correcta": 0
	},
	{
		"pregunta": "¿Qué es el comercio electrónico (e-commerce)?",
		"respuestas": [
			"Solo vender en tiendas físicas",
			"Vender productos online con sitios web",
			"Solo intercambiar productos",
			"Solo vender con efectivo"
		],
		"correcta": 1
	},
	{
		"pregunta": "¿Qué es un algoritmo en programación?",
		"respuestas": [
			"Un tipo de computadora",
			"Un lenguaje extranjero",
			"Una secuencia de pasos para resolver un problema",
			"Un instrumento musical"
		],
		"correcta": 2
	},
	{
		"pregunta": "¿Por qué las empresas necesitan programadores?",
		"respuestas": [
			"Solo para usar calculadoras",
			"Solo para escribir cartas",
			"Solo para organizar archivos",
			"Para automatizar procesos y crear soluciones"
		],
		"correcta": 3
	},
	{
		"pregunta": "¿Qué es la ciberseguridad?",
		"respuestas": [
			"Proteger sistemas y datos de ataques digitales",
			"Solo usar candados físicos",
			"Únicamente vigilar edificios",
			"Solo instalar cámaras de seguridad"
		],
		"correcta": 0
	},
	{
		"pregunta": "¿Cómo ayuda la programación en la medicina moderna?",
		"respuestas": [
			"Solo fabricando medicamentos",
			"Sistemas para hospitales y análisis médico",
			"Solo limpiando hospitales",
			"Solo transportando pacientes"
		],
		"correcta": 1
	},
	{
		"pregunta": "¿Qué es la computación en la nube (cloud computing)?",
		"respuestas": [
			"Solo usar computadoras blancas",
			"Solo trabajar en días nublados",
			"Almacenar y procesar datos en servidores remotos",
			"Solo usar papel"
		],
		"correcta": 2
	},
	{
		"pregunta": "¿Cuál es el futuro de la ingeniería de software?",
		"respuestas": [
			"Va a desaparecer pronto",
			"Solo para muy pocas personas",
			"No tendrá importancia",
			"Cada vez más demandada con nuevas tecnologías"
		],
		"correcta": 3
	},
	{
		"pregunta": "¿Qué es un desarrollador de aplicaciones móviles?",
		"respuestas": [
			"Repara teléfonos",
			"Crea apps para celulares y tablets",
			"Vende celulares",
			"Limpia pantallas"
		],
		"correcta": 1
	},
	{
		"pregunta": "¿Cómo impacta la tecnología en la educación?",
		"respuestas": [
			"Solo sirve para jugar",
			"No tiene ningún impacto",
			"Permite aprender online y acceder a recursos",
			"Solo complica el aprendizaje"
		],
		"correcta": 2
	},
	{
		"pregunta": "¿Qué es un programador de videojuegos?",
		"respuestas": [
			"Crea la lógica y mecánicas de los juegos",
			"Solo juega videojuegos",
			"Vende consolas",
			"Limpia computadoras"
		],
		"correcta": 0
	},
	{
		"pregunta": "¿Por qué es emocionante estudiar ingeniería de software?",
		"respuestas": [
			"Puedes crear tecnología que cambie el mundo",
			"Solo es trabajo de oficina aburrido",
			"No tiene ninguna creatividad",
			"Solo sirve para trabajos repetitivos"
		],
		"correcta": 0
	},
	{
		"pregunta": "¿Qué es la programación en el desarrollo de robots?",
		"respuestas": [
			"Dar instrucciones al robot para hacer tareas",
			"Solo ensamblar piezas mecánicas",
			"Solo pintar robots",
			"Solo mover robots manualmente"
		],
		"correcta": 0
	},
	{
		"pregunta": "¿Qué oportunidades laborales hay en tecnología?",
		"respuestas": [
			"Desarrollador, analista, arquitecto y muchas más",
			"Solo trabajos de limpieza",
			"Solo trabajos de ventas",
			"Solo trabajos de construcción"
		],
		"correcta": 0
	},
	{
		"pregunta": "¿Cómo pueden los jóvenes empezar a aprender programación?",
		"respuestas": [
			"Con cursos online gratuitos y apps educativas",
			"Solo en universidades caras",
			"Solo con libros muy antiguos",
			"Solo con conexiones familiares"
		],
		"correcta": 0
	}
];
var preguntas_restantes = []
var pregunta_actual = {}
var puntaje = 0

func _ready():
	# Selecciona 5 preguntas aleatorias sin repetir
	preguntas_restantes = []
	var preguntas_copia = preguntas.duplicate()
	for i in range(5):
		if preguntas_copia.size() == 0:
			break
		var pregunta = preguntas_copia.pick_random()
		preguntas_restantes.append(pregunta)
		preguntas_copia.erase(pregunta)
	puntaje = 0
	mostrar_pregunta_aleatoria()

func mostrar_pregunta_aleatoria():
	if preguntas_restantes.size() == 0:
		mostrar_resultado()
		return
	pregunta_actual = preguntas_restantes.pick_random()
	preguntas_restantes.erase(pregunta_actual)
	$Label.text = pregunta_actual["pregunta"]
	for i in range(4):
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
	$Label.text = "¡Trivia terminada!\nRespuestas correctas: %d de %d" % [puntaje, 5]
	for i in range(4):
		get_node("Boton%d" % i).hide()
	$Mensaje.text = ""
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://mundo.tscn")

func _on_boton_0_pressed() -> void:
	verificar_respuesta(0)
func _on_boton_1_pressed() -> void:
	verificar_respuesta(1)
func _on_boton_2_pressed() -> void:
	verificar_respuesta(2)
func _on_boton_3_pressed() -> void:
	verificar_respuesta(3)
