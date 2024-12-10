# Enemigo.gd
extends Node2D


@export var vida: int = 100
@export var daño: int = 10
@onready var Sprite = $Sprite


func _ready():
	Sprite.play("idle")

func atacar(objetivo):
	# Método común de ataque
	Sprite.play("attack")
	await Sprite.animation_finished
	objetivo.recibir_dano(daño)
	Sprite.play("idle")

func recibir_dano(cantidad):
	vida -= cantidad
	Sprite.play("hurt")
	await Sprite.animation_finished
	if vida <= 0:
		morir()
	Sprite.play("idle")

func morir():
	Sprite.play("dead")
	await Sprite.animation_finished
	queue_free()  # Elimina al enemigo de la escena
