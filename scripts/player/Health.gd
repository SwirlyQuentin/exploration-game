extends Node


@export var maxHealth = 100
@onready var healthBar:ProgressBar = $HealthBar
var currentHealth
signal die

func _ready():
    currentHealth = maxHealth
    healthBar.max_value = maxHealth
    healthBar.value = maxHealth

func takeDamage(damage):
    currentHealth -= damage
    healthBar.value = currentHealth
    print("DAMAGE TAKEN ", currentHealth)
    if (currentHealth <= 0):
        emit_signal("die")
    pass