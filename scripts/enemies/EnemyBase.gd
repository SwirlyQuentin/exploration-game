extends CharacterBody2D 

class_name EnemyBase

@export var health:int = 20

@onready var damageNumbers = $DamageNumbers
@onready var healthBar:ProgressBar = $HealthBar
@onready var hitFlash:AnimationPlayer = $Hitflash
@onready var healthPickup = preload("res://scenes/shared/HealthPickup.tscn")
@onready var healthContainer = self.get_tree().current_scene


signal deathSignal

var currentTotalDamage = 0
var damageTimer = 0
var damageWindow = 1
var damaging = false


func prepHealthBar():
    healthBar.max_value = health
    healthBar.value = health

func takeDamage(damage, character = null):
    if (hitFlash != null):
        print("playing")
        hitFlash.play("hit")
    currentTotalDamage += damage
    health -= damage
    healthBar.value = health
    damaging = true
    damageTimer = 0
    damageNumbers.text = str(currentTotalDamage)
    if (health <= 0):
        die()
    
    pass

func _process(delta):
    if (damaging):
        damageTimer += delta
        if (damageTimer > damageWindow):
            damaging = false
            currentTotalDamage = 0
            damageNumbers.text = ""

func die():
    emit_signal("deathSignal")
    checkDrop()
    queue_free()
    pass

func transitionCheck(sig):
    print(sig)

func checkDrop():
    var num = randi_range(0, 100)
    if (num <= 10):
        var h = healthPickup.instantiate()
        healthContainer.add_child(h)
        h.position = self.global_position
        print("made")
    pass


