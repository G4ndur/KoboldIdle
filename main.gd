extends Node2D
class_name main

func _ready() -> void:
	$tick_timer.start()



func _on_tick_timer_timeout() -> void:
	$HUD.update_hoard(str(globals.GP).pad_decimals(0) )
	#adds gp per sec to current gp
	globals.GP += globals.koboldGenPerSec /5.0
	
	#Manual Collect Cooldown
	
	if $HUD/CollectButton/collect_cooldown.is_stopped() == false:
		$HUD/CollectButton.disabled = true
		$HUD/CollectButton.text = "Collect Shinies! \n" + str($HUD/CollectButton/collect_cooldown.time_left).pad_decimals(1)  
	else:
		$HUD/CollectButton.disabled = false
		$HUD/CollectButton.text = "Collect Shinies! \n"
		
	#Unlocks
	if globals.GP >= 10:
		$HUD/HireKobold.visible = true
	
	
	#button disable
	if globals.GP < globals.koboldPrice:
		$HUD/HireKobold.disabled = true
	else:
		$HUD/HireKobold.disabled = false
	

func _on_collect_button_pressed() -> void:
	globals.GP += globals.manualCollect * globals.manualCollectMult
	$HUD/CollectButton/collect_cooldown.wait_time = globals.manualCollectCD * globals.manualCollectCDMult
	$HUD/CollectButton/collect_cooldown.start()


func _on_hire_kobold_pressed() -> void:
	print("press")
	globals.GP -= globals.koboldPrice
	globals.koboldPrice *= 1.20
	round(globals.koboldPrice)
	$HUD/HireKobold.text = "Hire a Kobold\n"+ str(globals.koboldPrice).pad_decimals(0) + " GP"
	globals.kobolds += 1
	globals.koboldGenPerSec += globals.koboldGen * globals.koboldGenMult
