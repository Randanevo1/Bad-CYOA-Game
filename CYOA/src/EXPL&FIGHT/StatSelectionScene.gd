extends Control

onready var PC = PlayerStats
onready var StatSel = $StatSelection
onready var StatNum = $StatSelection/HBoxContainer/StatPointNum
onready var HPNum = $StatSelection/Health/HPNum
onready var MPNum = $StatSelection/Mana/MPNum
onready var StrNum = $StatSelection/Strength/STRNum
onready var IntNum = $StatSelection/Intelligence/INTNum

var StatPoints = 5


func _ready():
	PC.health = 15
	PC.mana = 5
	PC.strength = 1
	PC.intelligence = 1

func _process(delta):
	StatNum.set_text("%d" % StatPoints)
	HPNum.set_text("%d" % PC.max_health)
	MPNum.set_text("%d" % PC.max_mana)
	StrNum.set_text("%d" % PC.strength)
	IntNum.set_text("%d" % PC.intelligence)

func _on_IPos1_button_up():
	if StatPoints > 0:
		PC.intelligence += 1
		StatPoints -= 1


func _on_INeg1_button_up():
	if PC.intelligence > 0:
		PC.intelligence -= 1
		StatPoints += 1


func _on_SNeg1_button_up():
	if PC.strength > 0:
		PC.strength -= 1
		StatPoints += 1


func _on_SPos1_button_up():
	if StatPoints > 0:
		PC.strength += 1
		StatPoints -= 1


func _on_MPos1_button_up():
	if StatPoints > 0:
		PC.max_mana += 1
		StatPoints -= 1


func _on_HPos1_button_up():
	if StatPoints > 0:
		PC.max_health += 1
		StatPoints -= 1


func _on_HNeg1_button_up():
	if PC.max_health > 14:
		PC.max_health -= 1
		StatPoints += 1


func _on_MNeg1_button_up():
	if PC.max_mana > 4:
		PC.max_mana -= 1
		StatPoints += 1
