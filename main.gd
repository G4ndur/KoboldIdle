extends Node2D
class_name main
var font = FontFile.new()
func _ready() -> void:
	font.font_data = load("res://alagard.woff2")
	$HUD/HoardLabel.set("custom_fonts/font", font)
	$HUD/GP.set("custom_fonts/font", font)
	$HUD/CollectGPLabel.set("custom_fonts/font", font)
	$HUD/CollectButton.set("custom_fonts/font", font)
	$HUD/HireKobold.set("custom_fonts/font", font)
	$HUD/KoboldCounter.set("custom_fonts/font", font)
	$HUD/HireMiner.set("custom_fonts/font", font)
	$HUD/MinerCounter.set("custom_fonts/font", font)
	$HUD/Upgrade01.set("custom_fonts/font", font)
	$HUD/Upgrade02.set("custom_fonts/font", font)
	$tick_timer.start()



func _on_tick_timer_timeout() -> void:
	$HUD.update_hoard(str(globals.GP).pad_decimals(0))
	#adds gp per sec to current gp
	globals.GP += globals.koboldGenPerSec /5.0
	globals.GP += globals.minerGenPerSec /5.0
	#Manual Collect Cooldown
	
	if $HUD/CollectButton/collect_cooldown.is_stopped() == false:
		$HUD/CollectButton.disabled = true
		$HUD/CollectButton.text = "Collect Shinies! \n" + str($HUD/CollectButton/collect_cooldown.time_left).pad_decimals(1)  
	else:
		$HUD/CollectButton.disabled = false
		$HUD/CollectButton.text = "Collect Shinies! \n"
		
	#Generator Unlocks
	if globals.GP >= 5:
		$HUD/HireKobold.visible = true
	
	if globals.GP >= 75:
		$HUD/HireMiner.visible = true
	
	#Upgrade Unlocks
	if $HUD/Upgrade01.purchased == true:
		pass
	elif globals.GP >= 5:
		$HUD/Upgrade01.visible = true
	if $HUD/Upgrade02.purchased == true:
		pass
	elif globals.kobolds >= 5:
		$HUD/Upgrade02.visible = true
	#button disable
	if globals.GP < globals.koboldPrice:
		$HUD/HireKobold.disabled = true
	else:
		$HUD/HireKobold.disabled = false
	if globals.GP < globals.minerPrice:
		$HUD/HireMiner.disabled = true
	else:
		$HUD/HireMiner.disabled = false
	
	if $HUD/Upgrade01.purchased == true:
		pass
	elif globals.GP < 15:
		$HUD/Upgrade01.disabled = true
	else:
		$HUD/Upgrade01.disabled = false
	if $HUD/Upgrade02.purchased == true:
		pass
	elif globals.GP < 50:
		$HUD/Upgrade02.disabled = true
	else:
		$HUD/Upgrade02.disabled = false
	

func _on_collect_button_pressed() -> void:
	globals.GP += globals.manualCollect * globals.manualCollectMult
	globals.manualCollectCounter += 1
	$HUD/CollectButton/collect_cooldown.wait_time = globals.manualCollectCD * globals.manualCollectCDMult
	$HUD/CollectButton/collect_cooldown.start()


func _on_hire_kobold_pressed() -> void:
	globals.GP -= globals.koboldPrice
	globals.kobolds += 1
	var pricegrowth = 1.2 ** globals.kobolds
	globals.koboldPrice = globals.KoboldBasePrice * pricegrowth
	round(globals.koboldPrice)
	if globals.GP < globals.koboldPrice:
		$HUD/HireKobold.disabled = true
	$HUD/HireKobold.text = "Hire a Kobold\n"+ str(globals.koboldPrice).pad_decimals(0) + " GP"
	globals.koboldGenPerSec =  globals.kobolds * globals.koboldGen * globals.koboldGenMult 
	$HUD/KoboldCounter.text = "Kobolds: " + str(globals.kobolds) + "\n" + "Generating " + str(globals.koboldGenPerSec).pad_decimals(1) + " GP/s"	

func _on_hire_miner_pressed() -> void:
	globals.GP -= globals.minerPrice
	
	globals.miners += 1
	var pricegrowth = 1.2 ** globals.miners
	globals.minerPrice = globals.minerBasePrice * pricegrowth
	round(globals.minerPrice)
	if globals.GP < globals.minerPrice:
		$HUD/HireMiner.disabled = true
	$HUD/HireMiner.text = "Hire a Miner\n" + str(globals.minerPrice).pad_decimals(0) + " GP"
	globals.minerGenPerSec = globals.miners * globals.minerGen * globals.minerGenMult
	if globals.minerGemChance >= 1:
		$HUD/MinerCounter.text = "Miners: " + str(globals.miners) + "\n" + "Generating " + str(globals.minerGenPerSec).pad_decimals(1) + " GP/s" + "\n" + "With a chance of " + str(globals.minerGemChance).pad_decimals(2) + "% for a gem each second!" 
	else:
		$HUD/MinerCounter.text = "Miners: " + str(globals.miners) + "\n" + "Generating " + str(globals.minerGenPerSec).pad_decimals(1) + " GP/s"
			


func _on_upgrade_01_pressed() -> void:
	globals.GP -= 15
	globals.manualCollect += 2
	$HUD/CollectGPLabel.text = "Currently gaining 3 GP
on Manual Collect"
	$HUD/Upgrade01.purchased = true
	$HUD/Upgrade01.visible = false


func _on_upgrade_02_pressed() -> void:
	globals.GP -= 50
	globals.koboldGenMult += 0.50
	globals.koboldGenPerSec =  globals.kobolds * globals.koboldGen * globals.koboldGenMult 
	$HUD/KoboldCounter.text = "Kobolds: " + str(globals.kobolds) + "\n" + "Generating " + str(globals.koboldGenPerSec).pad_decimals(1) + " GP/s"
	$HUD/HireKobold.tooltip_text = "Hiring a kobold grants you +"+ str(globals.koboldGen * globals.koboldGenMult) + "GP/s"
	$HUD/Upgrade02.purchased = true
	$HUD/Upgrade02.visible = false
