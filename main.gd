extends Node2D
class_name main
var GP = 0
func _ready() -> void:
	$tick_timer.start(0.2)


func _on_tick_timer_timeout() -> void:
	GP = GP+1
	print(GP)
	$HUD.update_hoard(GP)
