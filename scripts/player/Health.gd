extends Node


@export var maxHealth = 100
@onready var healthBar:ProgressBar = $HealthBar
var currentHealth
signal die

func _ready():
    Signals.connect("addHealth", gainHealth)
    if (PlayerManager.health != null):
        currentHealth = PlayerManager.health
    else:
        currentHealth = maxHealth
    PlayerManager.health = currentHealth
    healthBar.max_value = maxHealth
    healthBar.value = currentHealth

func takeDamage(damage):
    currentHealth -= damage
    healthBar.value = currentHealth
    print("DAMAGE TAKEN ", currentHealth)
    PlayerManager.health = currentHealth
    if (currentHealth <= 0):
        emit_signal("die")
    pass

func gainHealth(health):
    currentHealth += health
    if (currentHealth > maxHealth):
        currentHealth = maxHealth
    healthBar.value = currentHealth
    PlayerManager.health = currentHealth
    pass