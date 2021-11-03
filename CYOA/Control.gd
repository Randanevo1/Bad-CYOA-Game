extends Control

onready var mino = $MinotaurBox/Minotaur
onready var PC = $"/root/PlayerStats"


func _on_Attack_button_up():
	mino.health -= PC.strength
	PC.health -= mino.strength


func _on_Minotaur_no_health():
	get_tree().change_scene("res://Test.tscn")
