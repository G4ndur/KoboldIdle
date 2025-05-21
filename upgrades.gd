extends Node
@onready var upgrade01 = get_node("../HUD/Upgrade01")
@onready var upgrade02 = get_node("../HUD/Upgrade02")
@onready var upgrade03 = get_node("../HUD/Upgrade03")
@onready var upgrade04 = get_node("../HUD/Upgrade04")
@onready var upgrade05 = get_node("../HUD/Upgrade05")

func unlockCheckUpg():
	if upgrade01.purchased == true: pass
	elif globals.GP >= 5: upgrade01.visible = true
		
	if upgrade02.purchased == true: pass
	elif globals.kobolds >= 5: upgrade02.visible = true
		
	if upgrade03.purchased == true: pass
	elif globals.manualCollectCounter >= 10: upgrade03.visible = true
	
	if upgrade04.purchased == true: pass
	elif globals.miners >= 5: upgrade04.visible = true
	
	if upgrade05.purchased == true: pass
	elif globals.gems > 1: upgrade05.visible = true
		

func disableUpgBtnsPoor():
	#Upgrade 1
	if upgrade01.purchased == true:
		pass
	elif globals.GP < 15:
		upgrade01.disabled = true
	else:
		upgrade01.disabled = false

	#Upgrade 2
	if upgrade02.purchased == true:
		pass
	elif globals.GP < 50:
		upgrade02.disabled = true
	else:
		upgrade02.disabled = false

	#Upgrade 3
	if upgrade03.purchased == true:
		pass
	elif globals.GP < 150:
		upgrade03.disabled = true
	else:
		upgrade03.disabled = false
 
	#Upgrade 4
	if upgrade04.purchased == true:
		pass
	elif globals.GP < 500:
		upgrade04.disabled = true
	else:
		upgrade04.disabled = false
	
	#Upgrade 5
	if upgrade05.purchased == true:
		pass
	elif globals.gems < 10:
		upgrade05.disabled = true
	else:
		upgrade05.disabled = false
		

func _upgrade01Purchase() -> void:
	globals.GP -= 15
	globals.manualCollect += 2
	get_node("../HUD/CollectGPLabel").text = "Currently gaining 3 GP
on Manual Collect"
	upgrade01.purchased = true
	upgrade01.visible = false

func _upgrade02Purchase() -> void:
	globals.GP -= 50
	globals.koboldGenMult += 0.50
	globals.koboldGenPerSec =  globals.kobolds * globals.koboldGen * globals.koboldGenMult 
	get_node("../HUD/KoboldCounter").text = "Kobolds: " + str(globals.kobolds) + "\n" + "Generating " + str(globals.koboldGenPerSec).pad_decimals(1) + " GP/s"
	get_node("../HUD/HireKobold").tooltip_text = "Hiring a kobold grants you +"+ str(globals.koboldGen * globals.koboldGenMult) + "GP/s"
	upgrade02.purchased = true
	upgrade02.visible = false

func _upgrade03Purchase() -> void:
	globals.GP -= 150
	globals.manualCollectCD -= 1
	upgrade03.purchased = true
	upgrade03.visible = false

func _upgrade04Purchase() -> void:
	globals.GP -= 500
	globals.minerGemChance += 1
	get_node("../HUD/MinerCounter").text = "Miners: " + str(globals.miners) + "\n" + "Generating " + str(globals.minerGenPerSec).pad_decimals(1) + " GP/s" + "\n" + "With a Gemchance of " + str(globals.minerGemChance).pad_decimals(2) + "%\nfor every miner each second!" 
	upgrade04.purchased = true
	upgrade04.visible = false

func _upgrade05Purchase() -> void:
	globals.gems -= 10
	upgrade05.purchased = true
	upgrade05.visible = false
