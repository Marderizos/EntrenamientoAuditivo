extends Node

const INTERVALS = {
	"tercera_mayor": preload("res://sounds/tercera_mayor.wav"),
	"tercera_menor": preload("res://sounds/tercera_menor.wav"),
	"quinta_justa": preload("res://sounds/quinta_justa.wav"),
	"cuarta_justa": preload("res://sounds/cuarta_justa.wav")
}

@onready var interval_player = $IntervalPlayer
@onready var sfx_player = $SFXPlayer
@onready var bgm_player = $BGMPlayer

func play_random_interval() -> String:
	var intervals = INTERVALS.keys()
	var selected = intervals[randi() % intervals.size()]
	
	interval_player.stream = INTERVALS[selected]
	interval_player.play()
	
	return selected

func play_hit_sound():
	sfx_player.stream = preload("res://sounds/hit.wav")
	sfx_player.play()
