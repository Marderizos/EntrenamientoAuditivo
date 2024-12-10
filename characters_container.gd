extends Node2D

@onready var player_sprite = $Player/PlayerSprite
@onready var enemy_sprite = $Enemy/EnemySprite

func _ready():
	player_sprite.play("idle")
	enemy_sprite.play("idle")

func show_attack_result(player_won: bool):
	if player_won:
		player_sprite.play("attack")
		await player_sprite.animation_finished
		if player_sprite.animation != "dead":
			player_sprite.play("idle")
	else:
		enemy_sprite.play("attack")
		await enemy_sprite.animation_finished
		if enemy_sprite.animation != "dead":
			enemy_sprite.play("idle")

# Podemos añadir estas funciones para manejar el retorno a idle después de hurt
func return_to_idle_after_hurt(sprite: AnimatedSprite2D):
	await sprite.animation_finished
	if sprite.animation != "dead":
		sprite.play("idle")
