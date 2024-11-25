extends CharacterBody2D 

class_name EnemyBase

@onready var damageNumbers = $DamageNumbers
@onready var healthBar:ProgressBar = $HealthBar


var currentTotalDamage = 0
var health = 50
var damageTimer = 0
var damageWindow = 1
var damaging = false


func prepHealthBar():
    healthBar.max_value = health
    healthBar.value = health

func takeDamage(damage):
    currentTotalDamage += damage
    health -= damage
    healthBar.value = health
    damaging = true
    damageTimer = 0
    damageNumbers.text = str(currentTotalDamage)
    if (health <= 0):
        queue_free()
    
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


