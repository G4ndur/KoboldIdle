extends Node2D
class_name main
var font = FontFile.new()
func _ready() -> void:
	fontLoad()
	$tick_timer.start()

func _on_tick_timer_timeout() -> void:
	$generators.generateGPPerTick()
	#Manual Collect Cooldown
	$generators.manualCollectCD()
	#Generator Unlocks
	$generators.unlockCheckGens()
	#Upgrade Unlocks
	$upgrades.unlockCheckUpg()
	#button disable
	$generators.disableGenBtnsPoor()
	$upgrades.disableUpgBtnsPoor()

func fontLoad():
	font.font_data = load("res://alagard.woff2")
	$HUD/HoardLabel.set("custom_fonts/font", font)
	$HUD/GP.set("custom_fonts/font", font)
	$HUD/TotalGPps.set("custom_fonts/font", font)
	$HUD/UpgradesLbl.set("custom_fonts/font", font)
	$HUD/GensLbl.set("custom_fonts/font", font)
	$HUD/CollectGPLabel.set("custom_fonts/font", font)
	$HUD/CollectButton.set("custom_fonts/font", font)
	$HUD/HireKobold.set("custom_fonts/font", font)
	$HUD/KoboldCounter.set("custom_fonts/font", font)
	$HUD/HireMiner.set("custom_fonts/font", font)
	$HUD/MinerCounter.set("custom_fonts/font", font)
	$HUD/Upgrade01.set("custom_fonts/font", font)
	$HUD/Upgrade02.set("custom_fonts/font", font)
	$HUD/Upgrade03.set("custom_fonts/font", font)
	$HUD/Upgrade04.set("custom_fonts/font", font)
	$HUD/Upgrade05.set("custom_fonts/font", font)
