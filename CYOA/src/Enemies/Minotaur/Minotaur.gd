extends Stats


func _process(delta):
	if health == 0:
		emit_signal("no_health")
