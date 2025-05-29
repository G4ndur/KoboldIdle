extends Node
var GP 						= Big.new(1)
var gems					= Big.new(0)
#Manual Collecting
var manualCollect 			= Big.new(1)
var manualCollectMult 		= Big.new(1)
var manualCollectCD 		= 3
var manualCollectCDMult 	= 1
var manualCollectCounter 	= Big.new(0)
#Total GP Generation
var gpGenPerSec 			= Big.new(0)
var gpGenPerSecMult 		= Big.new(1)
#Kobolds
var kobolds 				= Big.new(0)
var KoboldBasePrice 		= Big.new(10)
var koboldPrice 			= Big.new(10)
var koboldGen 				= Big.new(0.5)
var koboldGenMult 			= Big.new(1)
var koboldGenPerSec 		= Big.new(0)
#Miner
var miners 					= Big.new(0)
var minerBasePrice 			= Big.new(100)
var minerPrice 				= Big.new(100)
var minerGen				= Big.new(5)
var minerGenMult			= Big.new(1)
var minerGenPerSec			= Big.new(0)
var minerGemChance			= Big.new(0)
