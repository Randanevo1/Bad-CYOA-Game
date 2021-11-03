extends Node
class_name Stats

signal no_health

export(String) var Name

export(int) var max_health
export(int) var max_mana
onready var health = max_health
onready var mana = max_mana


export(int) var strength
export(int) var intelligence
export(int) var speed

export var MapPos = 1

var key2  = false
var key11 = false
