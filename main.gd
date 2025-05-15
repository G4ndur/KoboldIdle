extends Node2D
class_name main

var GP = 0
func _ready() -> void:
	$tick_timer.start()



func _on_tick_timer_timeout() -> void:
	$HUD.update_hoard(GP)
	print($HUD/CollectButton/collect_cooldown.time_left)
	if $HUD/CollectButton/collect_cooldown.is_stopped() == false:
		$HUD/CollectButton.disabled = true
	else:
		$HUD/CollectButton.disabled = false

func _on_collect_button_pressed() -> void:
	GP = GP + 1
	$HUD/CollectButton/collect_cooldown.start(5)
