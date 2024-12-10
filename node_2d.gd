extends Node2D

signal battle_ended(victory: bool)

@onready var battle_manager = $BattleManager
@onready var ui_manager = $UI

func _ready():
	battle_manager.connect("player_damaged", ui_manager.update_player_health)
	battle_manager.connect("enemy_damaged", ui_manager.update_enemy_health)
	battle_manager.connect("battle_ended", _on_battle_ended)
	battle_manager.start_battle()
	ui_manager.selected_interval.connect(battle_manager.process_player_answer)

func _on_battle_ended(victory: bool):
	emit_signal("battle_ended", victory)
	print("La batalla finalizó, ¿Has vencido? The answer is ",victory )
