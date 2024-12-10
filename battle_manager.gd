extends Node

signal player_damaged(new_health: int)
signal enemy_damaged(new_health: int)
signal battle_ended(victory: bool)

var player_health = 100
var enemy_health = 100
var current_interval = ""
var battle_is_over = false

@onready var audio_manager = $"../AudioManager"
@onready var combat_timer = $CombatTimer
@onready var characters = $"../CharactersContainer"

func start_battle():
	battle_is_over = false
	enemy_attack()

func enemy_attack():
	if battle_is_over:
		return
		
	current_interval = audio_manager.play_random_interval()
	characters.enemy_sprite.play("attack")
	combat_timer.start()
	await characters.enemy_sprite.animation_finished
	if not battle_is_over:
		characters.enemy_sprite.play("idle")

func process_player_answer(selected_interval: String):
	if battle_is_over:
		return
		
	combat_timer.stop()
	print("El intervalo recibido fue ", selected_interval)
	
	if selected_interval == current_interval:
		# Respuesta correcta
		if enemy_health > 0:
			damage_enemy(20)
			characters.show_attack_result(true)
			await get_tree().create_timer(0.5).timeout  # Tiempo para que se vea la animación
	else:
		# Respuesta incorrecta
		if player_health > 0:
			damage_player(20)
			characters.show_attack_result(false)
			await get_tree().create_timer(0.5).timeout  # Tiempo para que se vea la animación
	
	check_battle_state()

func damage_player(amount: int):
	if player_health > 0:
		player_health = max(0, player_health - amount)
		audio_manager.play_hit_sound()
		characters.player_sprite.play("hurt")
		characters.return_to_idle_after_hurt(characters.player_sprite)
		emit_signal("player_damaged", player_health)

func damage_enemy(amount: int):
	if enemy_health > 0:
		enemy_health = max(0, enemy_health - amount)
		characters.enemy_sprite.play("hurt")
		audio_manager.play_hit_sound()
		characters.return_to_idle_after_hurt(characters.enemy_sprite)
		emit_signal("enemy_damaged", enemy_health)

func check_battle_state():
	if player_health <= 0:
		battle_is_over = true
		characters.player_sprite.play("dead")
		await characters.player_sprite.animation_finished
		characters.player_sprite.queue_free()
		emit_signal("battle_ended", false)
	elif enemy_health <= 0:
		battle_is_over = true
		characters.enemy_sprite.play("dead")
		await characters.enemy_sprite.animation_finished
		characters.enemy_sprite.queue_free()
		emit_signal("battle_ended", true)
	else:
		await get_tree().create_timer(1.0).timeout  # Reducido de 1.5 a 1.0 para mejor ritmo
		if not battle_is_over:
			enemy_attack()
