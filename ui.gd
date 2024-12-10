extends CanvasLayer

@onready var health_bar_player = $HealthBars/PlayerHealth/ProgressBar
@onready var health_bar_enemy = $HealthBars/EnemyHealth/ProgressBar
@onready var health_label_player = $HealthBars/PlayerHealth/Label
@onready var health_label_enemy = $HealthBars/EnemyHealth/Label
@onready var button_container = $ButtonContainer
@onready var timer_label = $TimerLabel

signal selected_interval(interval: String)

func _ready():
	setup_interval_buttons()
	update_player_health(100)
	update_enemy_health(100)
	print("Probando")

func setup_interval_buttons():
	for interval in ["tercera_mayor", "tercera_menor", "quinta_justa", "cuarta_justa"]:
		var button = Button.new()
		button.text = interval.capitalize()
		button.custom_minimum_size = Vector2(120, 40)
		button.connect("pressed", _on_interval_button_pressed.bind(interval))
		print("Se conectó a la función el botón del intervalo ", interval)
		button_container.add_child(button)

func _on_interval_button_pressed(interval: String):
	emit_signal("selected_interval", interval)
	print("Se emitió el intervalo ", interval)

func update_player_health(new_health: int):
	health_bar_player.value = new_health
	health_label_player.text = "Vida: %d" % new_health

func update_enemy_health(new_health: int):
	health_bar_enemy.value = new_health
	health_label_enemy.text = "Vida: %d" % new_health

func update_timer(time_left: float):
	timer_label.text = "Tiempo: %.1f" % time_left
