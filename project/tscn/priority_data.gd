extends Node

var priority_data : Array = [
[99999999, "red dragon"],
[99999998, "goblin bomber"],
[99999997, "blue dragon"],
[99999997, "shopkeeper"],
[99999997, "pawnbroker"],
[99999996, "blademaster"],
[99999995, "apprentice blademaster"],
[99100000, "conga line zombies"],
[99000000, "king conga"],
[80000000, "leprechaun"],
[49000000, "king"],
[48000000, "queen"],
[47000000, "rook"],
[46000000, "bishop"],
[45000000, "knight"],
[44000000, "pawn"],
[41000001, "golden lute body"],
[41000000, "golden lute head"],
[40606100, "dead ringer"],
[40309300, "death metal"],
[40309300, "necrodancer"],
[40302202, "black drum tentacle"],
[40302202, "black horn tentacle"],
[40302202, "black violin tentacle"],
[40302202, "black keyboard tentacle"],
[40302100, "coral riff"],
[40202100, "fortissimole"],
[40201202, "drum tentacle"],
[40201202, "horn tentacle"],
[40201202, "violin tentacle"],
[40201202, "keyboard tentacle"],
[40103400, "conductor"],
[40040100, "frankensteinway"],
[30608220, "earth dragon"],
[30604115, "green banshee"],
[30505215, "blood nightmare"],
[30505115, "ogre"],
[30505115, "green metrognome"],
[30505115, "dark minotaur"],
[30405215, "mommy"],
[30404210, "green dragon"],
[30403215, "brown direbat"],
[30403210, "nightmare"],
[30403115, "gold metrognome"],
[30403110, "blue banshee"],
[30403110, "light minotaur"],
[30302210, "yellow direbat"],
[30201103, "mummy"],
[20607407, "dark golem"],
[20510407, "ooze golem"],
[20405404, "light golem"],
[20302302, "fire elemental"],
[20302302, "ice elemental"],
[20301403, "yeti"],
[19901101, "green slime"],
[10603106, "black skeleton knight"],
[10602105, "grey goblin"],
[10503206, "black armored skeleton"],
[10503206, "black windmage"],
[10404402, "black lich"],
[10404302, "red lich"],
[10404202, "lich"],
[10403303, "purple mushroom"],
[10403204, "golden electric mage"],
[10403204, "black skeleton"],
[10403200, "black skull"],
[10402305, "green devil"],
[10402204, "yellow windmage"],
[10402104, "yellow skeleton knight"],
[10401302, "neon warlock"],
[10401202, "spider"],
[10401202, "warlock"],
[10401120, "black bat"],
[10401103, "purple goblin"],
[10401102, "pixie"],
[10401102, "gargoyle"],
[10401100, "golden electric orb"],
#[10305103, "doppleganger"],
[10304103, "tar monster"],
[10303202, "fire beetle"],
[10303202, "ice beetle"],
[10303104, "orange armadillo"],
[10303104, "purple orc"],
[10302204, "yellow armored skeleton"],
[10302203, "red electric mage"],
[10302203, "yellow skeleton"],
[10302105, "yellow armadillo"],
#[10301404, "toad"],
[10301203, "harpy"],
[10301202, "hellhound"],
[10301120, "green bat"],
[10301102, "clone"],
[10301102, "ghoul(z4 skyblue spirit)"],
[10301102, "purple slime"],
#[10301102, "black slime"],
[10301101, "fire slime"],
[10301101, "ice slime"],
[10301100, "red electric orb"],
[10301100, "locked chest mimic"],
[10301100, "white chest mimic"],
[10202202, "blue slime"],
[10202200, "yellow skull"],
[10202105, "pink evileye"],
[10202103, "pink orc"],
[10201402, "blue mushroom"],
[10201303, "red devil"],
[10201202, "white windmage"],
[10201201, "zombie"],
[10201103, "wall mimic"],
[10201103, "red bat"],
[10201103, "wight(z2 green spirit)"],
[10201102, "white skeleton knight"],
[10201102, "white armadillo"],
[10201102, "ghast(z3 pink spirit)"],
[10201102, "ghost"],
[10201102, "hotcoal cauldron mimic"],
[10201100, "shop wall mimic"],
[10201100, "crate mimic"],
[10201100, "barrel mimic"],
[10201100, "shrine mimic"],
[10201100, "red chest mimic"],
[10103915, "black sarcophagus"],
[10102910, "yellow sarcophagus"],
[10101805, "white sarcophagus"],
[10101202, "white armored skeleton"],
[10101202, "blue bat"],
[10101202, "white skeleton"],
[10101202, "electric mage"],
[10101201, "goblin sentry"],
#[10101200, "crystal skull"],
[10101200, "white skull"],
[10101103, "evileye"],
[10101102, "green orc"],
[10101102, "orange slime"],
[10101102, "wraith(z1 red spirit)"],
[10101101, "electric zombie"],
#[10101100, "conductor sarcophagus"],
[10101100, "purple electric orb"],
[10006103, "white monkey"],
[10004103, "green monkey"],
[10004101, "purple monkey"],
[10003102, "grey shove monster"],
[10003100, "golden gorgon"],
[10002103, "magic monkey"],
[10002102, "shove monster"],
[10001102, "green gorgon"],
[10001102, "cursed wraith(z5 yellow spirit)"],
[10001101, "waterball"]
]

var only_priority_list : Array = []
var only_name_list : Array = []

func _ready():
	only_priority_list.clear()
	
	for data in priority_data:
		
		only_name_list.append(data[1])
		
		if only_priority_list.has(data[0]):
			continue
		else:
			only_priority_list.append(data[0])
	
	only_name_list.sort()
	#print( only_priority_list )
	#print( only_name_list )

func get_names_by_priority(priority) -> Array:
	var names : Array = []
	
	for data in priority_data:
		if( data[0] == int(priority) ):
			names.append( data[1] )
	
	return names

func get_priority_by_name(name : String) -> int:
	for data in priority_data:
		if( name.nocasecmp_to(data[1]) == 0 ):
			return data[0]
	
	# Edge case implement
	if name.nocasecmp_to("Freddie") == 0:
		return 99999997
	
	if name.nocasecmp_to("congaline zombies") == 0 or name.nocasecmp_to("conga zombies") == 0:
		return 99100000
	if name.nocasecmp_to("congaline zombie") == 0 or name.nocasecmp_to("conga zombie") == 0:
		return 99100000

	if name.nocasecmp_to("Waski") == 0 or name.nocasecmp_to("Waski115") == 0:
		return 30403110
	
	if name.nocasecmp_to("Green Waski") == 0 or name.nocasecmp_to("Waski's sister") == 0:
		return 30604115
	
	if name.nocasecmp_to("turnip") == 0:
		return 30201103
	
	if name.nocasecmp_to("klappa") == 0:
		return 20301403
	
	if name.nocasecmp_to("tuf") == 0 or name.nocasecmp_to("tufwfo") == 0:
		return 19901101
	
	if name.nocasecmp_to("didyouknow") == 0 or name.nocasecmp_to("did you know") == 0:
		return 10602105
	
	if name.nocasecmp_to("ghoul") == 0:
		return 10301102
	
	if name.nocasecmp_to("wight") == 0:
		return 10201103
	
	if name.nocasecmp_to("ghast") == 0:
		return 10201102
	
	if name.nocasecmp_to("cauldron mimic") == 0:
		return 10201102
	
	if name.nocasecmp_to("black sarc") == 0:
		return 10103915
	
	if name.nocasecmp_to("yellow sarc") == 0:
		return 10102910
	
	if name.nocasecmp_to("white sarc") == 0:
		return 10101805
	
	if name.nocasecmp_to("wraith") == 0:
		return 10101102
	
	if name.nocasecmp_to("cursed wraith") == 0:
		return 10001102
	
	if name.nocasecmp_to("hotdog") == 0:
		return 10301202
	
	if name.nocasecmp_to("greg") == 0 or name.nocasecmp_to("henry") == 0:
		return 10301120
	
	if name.nocasecmp_to("goof") == 0 or name.nocasecmp_to("purple monkey") == 0:
		return 10002103
	
	return 0

func autocomplete(sub_name : String) -> Array:
	var available_names : Array = []
	
	for data in only_name_list:
		if( sub_name.is_subsequence_ofi(data) and not sub_name == data ):
			available_names.append(data)
	
	return available_names
