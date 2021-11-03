extends VBoxContainer

onready var stats = $"/root/PlayerStats"

func _process(_delta):
	$Name.set_text("Player")
	$HP.set_text("HP: %d/%d" % [stats.health, stats.max_health])
	$MP.set_text("MP: %d/%d" % [stats.mana, stats.max_mana])
	$STR.set_text("STR: %d" % stats.strength)
	$INT.set_text("INT: %d" % stats.intelligence)
	$SPD.set_text("SPD: %d" % stats.speed)
