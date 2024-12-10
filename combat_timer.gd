extends Timer

signal time_expired

@onready var battle_manager = $"/root/Node2D/BattleManager"
@onready var ui_manager = $"/root/Node2D/UI"

func _ready():
	wait_time = 3.0
	connect("timeout", _on_timeout)

#func _process(_delta):
	#if time_left > 0:
		#ui_manager.update_timer(time_left)

func _on_timeout():
	battle_manager.damage_player(20)
	battle_manager.check_battle_state()
