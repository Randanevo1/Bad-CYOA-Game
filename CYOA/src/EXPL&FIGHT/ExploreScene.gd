extends Control

onready var PC = $"/root/PlayerStats"
onready var Map   = $Maps
onready var TextBox = $TextBox
onready var North = $ChoiceButtons/North
onready var South = $ChoiceButtons/South
onready var West  = $ChoiceButtons/West
onready var East  = $ChoiceButtons/East
onready var Choices = $ChoiceButtons
onready var B_Choices = $BattleButtons
onready var mapposloc = $"Current Room"
onready var EnemyBox = $Enemies/MinotaurBox
onready var Enemy = $Enemies/MinotaurBox/Minotaur

# Tracks Players current room position
onready var PC_Map_Pos = Map.get_node("1")

var NorthRoom
var SouthRoom
var WestRoom
var EastRoom

func _ready():
	PC.health = PC.max_health
	PC.mana = PC.max_mana
	Check_Connections()
	RoomDesc()

func _process(_delta):
	mapposloc.set_text("Current room: %s" % PC_Map_Pos.name)
	if PC.health <= 0:
		get_tree().change_scene("res://src/EXPL&FIGHT/LoseScreen.tscn")

func Check_Connections():
	# Check boolean values for directions in node player is in
	if PC_Map_Pos.north == true:
		North.disabled = false
		NorthRoom = PC_Map_Pos.RoomNorth
	else:
		North.disabled = true
	
	if PC_Map_Pos.south == true:
		South.disabled = false
		SouthRoom = PC_Map_Pos.RoomSouth
	else:
		South.disabled = true
	
	if PC_Map_Pos.west  == true:
		West.disabled = false
		WestRoom = PC_Map_Pos.RoomWest
	else:
		West.disabled = true
	
	if PC_Map_Pos.east  == true:
		East.disabled = false
		EastRoom = PC_Map_Pos.RoomEast
	else:
		East.disabled = true
	# Checks for Room interactibals
	if PC_Map_Pos.bed == false:
		Choices.get_node("Rest").visible = false
	else:
		Choices.get_node("Rest").visible = true

func RoomTravel(direction):
	
	if direction == "n":
		PC_Map_Pos = $Maps.get_node(NorthRoom)
	elif direction == "w":
		PC_Map_Pos = $Maps.get_node(WestRoom)
	elif direction == "s":
		PC_Map_Pos = $Maps.get_node(SouthRoom)
	elif direction == "e":
		PC_Map_Pos = $Maps.get_node(EastRoom)
	Check_Connections()
	TextBox.clear()
	RoomDesc()
	Encounter()
	if PC_Map_Pos.Win == true:
		get_tree().change_scene("res://src/EXPL&FIGHT/WinScreen.tscn")

func RoomDesc():
	if PC_Map_Pos.bed == true:
		TextBox.add_text("There is a bed in this room\n\n")
	if PC_Map_Pos.north == true:
		TextBox.add_text("There is a path to the north\n\n")
	if PC_Map_Pos.south == true:
		TextBox.add_text("There is a path to the south\n\n")
	if PC_Map_Pos.west == true:
		TextBox.add_text("There is a path to the west\n\n")
	if PC_Map_Pos.east == true:
		TextBox.add_text("There is a path to the east\n\n")

func Encounter():
	if PC_Map_Pos.Enemy == true:
		set_health()
		TextBox.clear()
		EnemyBox.visible = true
		Choices.visible = false
		B_Choices.visible = true

func set_health():
	Enemy.health = Enemy.max_health
	Enemy.mana = Enemy.max_mana


func _on_North_button_up():
		RoomTravel("n")

func _on_West_button_up():
		RoomTravel("w")

func _on_South_button_up():
		RoomTravel("s")

func _on_East_button_up():
		RoomTravel("e")

func _on_Rest_button_up():
	if PC.health < PC.max_health or PC.mana < PC.max_mana:
		TextBox.add_text("You rest until you are fully healed")
		PC.health = PC.max_health
		PC.mana   = PC.max_mana
	else:
		TextBox.add_text("You do not need to rest")


func _on_Attack_button_up():
	TextBox.clear()
	Enemy.health -= PC.strength
	PC.health -= Enemy.strength
	TextBox.add_text("You dealt %d damage to the Minotaur\n\n" % PC.strength)
	TextBox.add_text("The Minotaur dealt %d damage to you" % Enemy.strength)

func _on_Defend_button_up():
	var E_Attack_Block = Enemy.strength / 2
	PC.health -= E_Attack_Block
	TextBox.clear()
	TextBox.add_text("You blocked the Minotaur's attack and took %d dmg" % E_Attack_Block)

func _on_Fireball_button_up():
	Enemy.health -= PC.intelligence
	PC.health -= Enemy.strength
	TextBox.clear()
	TextBox.add_text("You casted fireball and dealt %d damage\n\n" % PC.intelligence)
	TextBox.add_text("The Minotaur dealt %d damage to you" % Enemy.strength)


func _on_MinotaurBox_dead():
	B_Choices.visible = false
	Choices.visible = true
	PC_Map_Pos.Enemy = false
	Enemy.health = 1
	EnemyBox.visible = false
	TextBox.clear()
	TextBox.add_text("You defeated the Minotaur!\n\n")
	RoomDesc()
