extends VBoxContainer

onready var mino = $Minotaur

signal dead

func _process(_delta):
	$Name.set_text("Minotaur")
	$HP.set_text("HP: %d/%d" % [mino.health, mino.max_health])
	$Mana.set_text("MP: %d/%d" % [mino.mana, mino.max_mana])
	$Str.set_text("STR: %d" % mino.strength)
	$Int.set_text("INT: %d" % mino.intelligence)
	$Spd.set_text("SPD: %d" % mino.speed)
	if mino.health <= 0:
		emit_signal("dead")
