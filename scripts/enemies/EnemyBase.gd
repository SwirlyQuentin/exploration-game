extends CollisionObject2D

class_name EnemyBase

@onready var damageNumbers = $DamageNumbers


var currentTotalDamage = 0
var health = 100
var damageTimer = 0
var damageWindow = 1
var damaging = false


func takeDamage(damage):
	currentTotalDamage += damage
	health -= damage
	damaging = true
	damageTimer = 0
	damageNumbers.text = str(currentTotalDamage)
	
	pass

func _process(delta):
	if (damaging):
		damageTimer += delta
		if (damageTimer > damageWindow):
			damaging = false
			currentTotalDamage = 0
			damageNumbers.text = ""

func transitionCheck(sig):
	print(sig)


