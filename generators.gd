extends Node
var rng = RandomNumberGenerator.new()
var tickcount = 0
@onready var collectBtn = get_node("../HUD/CollectButton")
@onready var collectBtnCd = get_node("../HUD/CollectButton/collect_cooldown")

#Cooldowns for manual collection
func manualCollectCD():
	if collectBtnCd.is_stopped() == false:
		collectBtn.disabled = true
		collectBtn.text = "Collect Shinies! \n" + str(collectBtnCd.time_left).pad_decimals(1)  
	else:
		collectBtn.disabled = false
		collectBtn.text = "Collect Shinies! \n"
		
func calcGPS():
	globals.gpGenPerSec = globals.koboldGenPerSec + globals.minerGenPerSec
#Base Function for automatic GP Generation
func generateGPPerTick():
	get_node("../HUD/GP").text = "Gold Pieces: " + str(globals.GP).pad_decimals(0)
	if get_node("../HUD/Upgrade05").purchased == true:
		get_node("../HUD/CollectGPLabel").text = "Currently gaining "+ str(globals.manualCollect * globals.manualCollectMult + (globals.koboldGenPerSec / 10.0) + (globals.minerGenPerSec / 10.0)) +" GP
		on Manual Collect"
	else:
		get_node("../HUD/CollectGPLabel").text = "Currently gaining "+ str(globals.manualCollect * globals.manualCollectMult) +" GP
		on Manual Collect"
	calcGPS()
	get_node("../HUD/TotalGPps").text = "Generating "+ str(globals.gpGenPerSec) + " GP/s"
	#adds gp per sec to current gp
	globals.GP += globals.koboldGenPerSec + globals.minerGenPerSec /5.0
	#add gems
	if get_node("../HUD/Upgrade04").purchased == true:
		tickcount += 1
		if tickcount >= 5:
			tickcount = 0
			for n in range(globals.miners):
				if rng.randf_range(0.0,100) <= globals.minerGemChance:
					globals.gems += 1
					get_node("../HUD/Gems").text = "Gems: " + str(globals.gems).pad_decimals(0)
				else: pass
		else: pass
	else:
		pass
#Unlock checker
func unlockCheckGens():
	if globals.GP >= 5:
		get_node("../HUD/HireKobold").visible = true
	
	if globals.GP >= 75:
		get_node("../HUD/HireMiner").visible = true

func disableGenBtnsPoor():
	if globals.GP < globals.koboldPrice:
		get_node("../HUD/HireKobold").disabled = true
	else:
		get_node("../HUD/HireKobold").disabled = false
	if globals.GP < globals.minerPrice:
		get_node("../HUD/HireMiner").disabled = true
	else:
		get_node("../HUD/HireMiner").disabled = false


func _on_collect_button_pressed() -> void:
	if get_node("../HUD/Upgrade05").purchased == true:
		globals.GP += globals.manualCollect * globals.manualCollectMult + (globals.koboldGenPerSec / 10.0) + (globals.minerGenPerSec / 10.0)
		globals.manualCollectCounter += 1
		collectBtnCd.wait_time = globals.manualCollectCD * globals.manualCollectCDMult
		collectBtnCd.start()
	else:
		globals.GP += globals.manualCollect * globals.manualCollectMult
		globals.manualCollectCounter += 1
		collectBtnCd.wait_time = globals.manualCollectCD * globals.manualCollectCDMult
		collectBtnCd.start()


func _on_hire_kobold_pressed() -> void:
	globals.GP -= globals.koboldPrice
	globals.kobolds += 1
	var pricegrowth = 1.2 ** globals.kobolds
	globals.koboldPrice = globals.KoboldBasePrice * pricegrowth
	round(globals.koboldPrice)
	if globals.GP < globals.koboldPrice:
		get_node("../HUD/HireKobold").disabled = true
	get_node("../HUD/HireKobold").text = "Hire a Kobold\n"+ str(globals.koboldPrice).pad_decimals(0) + " GP"
	globals.koboldGenPerSec =  globals.kobolds * globals.koboldGen * globals.koboldGenMult 
	get_node("../HUD/KoboldCounter").text = "Kobolds: " + str(globals.kobolds) + "\n" + "Generating " + str(globals.koboldGenPerSec).pad_decimals(1) + " GP/s"	


func _purchaseMiner() -> void:
	globals.GP -= globals.minerPrice
	
	globals.miners += 1
	var pricegrowth = 1.2 ** globals.miners
	globals.minerPrice = globals.minerBasePrice * pricegrowth
	round(globals.minerPrice)
	if globals.GP < globals.minerPrice:
		get_node("../HUD/HireMiner").disabled = true
	get_node("../HUD/HireMiner").text = "Hire a Miner\n" + str(globals.minerPrice).pad_decimals(0) + " GP"
	globals.minerGenPerSec = globals.miners * globals.minerGen * globals.minerGenMult
	if globals.minerGemChance >= 1:
		get_node("../HUD/MinerCounter").text = "Miners: " + str(globals.miners) + "\n" + "Generating " + str(globals.minerGenPerSec).pad_decimals(1) + " GP/s" + "\n" + "With a Gemchance of " + str(globals.minerGemChance).pad_decimals(2) + "%\nfor every miner each second!" 
	else:
		get_node("../HUD/MinerCounter").text = "Miners: " + str(globals.miners) + "\n" + "Generating " + str(globals.minerGenPerSec).pad_decimals(1) + " GP/s"
