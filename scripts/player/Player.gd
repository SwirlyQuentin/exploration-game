extends CharacterBody2D

@onready var playerBullet = preload("res://scenes/player/PlayerBullet.tscn")
@onready var bulletContainer = $Bullets
@onready var shootingPoint = $Hand/ShootingPoint
@onready var hand = $Hand
@onready var sprite:AnimatedSprite2D = $Rat
@onready var health = $Health
@onready var hitBox = $Hitbox

const speed = 12000.0
var handDistance = 70
@export var dashTime = 0.2
var dashTimer = 0
var dashSpeed = 30000
var dashing = false
var direction = Vector2()
var dead = false
var speedMod = 1
var tutorial = false
var disabled = false

func _ready():
    print("player ready")
    health.connect("die", die)
    Signals.connect("tutorial", tutorialValues)
    Signals.connect("enablePlayer", enable)
    Signals.connect("disablePlayer", disable)


func _input(event):
    if (event.is_action_pressed("shoot") && !tutorial):
        shoot()
    elif (event.is_action_pressed("dash") && !dashing && !tutorial):
        dash()


func _physics_process(delta: float) -> void:
    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    if (dead || disabled):
        return

    positionHand()

    if (!dashing && !disabled):
        var xdirection = Input.get_axis("left", "right")
        var ydirection = Input.get_axis("up", "down")
        direction = Vector2(xdirection, ydirection)

        if (!direction):
            direction.x = move_toward(direction.x, 0, speed)
            direction.y = move_toward(direction.y, 0, speed)


        if (xdirection < 0):
            sprite.flip_h = false
        elif (xdirection > 0):
            sprite.flip_h = true
        if (ydirection < 0):
            sprite.flip_v = false
        elif (ydirection > 0):
            sprite.flip_v = true

    if (direction != Vector2.ZERO):
        if (abs(direction.y) > abs(direction.x)):
            sprite.animation = "vertRun"
        else:
            sprite.animation = "running"
            sprite.flip_v = false
    else:
        sprite.flip_v = false
        sprite.animation = "default"
        pass

    if (dashing):
        velocity = direction.normalized() * dashSpeed * delta
        checkDash(delta)
    elif (disabled):
        self.velocity = Vector2.ZERO
    else:
        velocity = direction.normalized() * speed * speedMod * delta


    move_and_slide()


func _on_render_distance_area_entered(area:Area2D) -> void:
    if (!area.parent.isPuzzle):
        area.parent.setEnabled()
        print("AREA ", area)


func _on_render_distance_area_exited(area:Area2D) -> void:
    if (!area.parent.isPuzzle):
        area.parent.setDisabled()

func shoot():
    var b:Area2D = playerBullet.instantiate()
    bulletContainer.add_child(b)
    b.damage = int(randf_range(3 * (PlayerManager.data["totalCollectables"] + 1) , 6 * (PlayerManager.data["totalCollectables"] + 1)))
    b.global_position = shootingPoint.global_position
    b.direction = get_global_mouse_position() - shootingPoint.global_position
    b.rotation = b.direction.angle() + deg_to_rad(90)
    pass


func positionHand():
    var tar = (get_global_mouse_position() - self.position).normalized()
    tar *= handDistance
    hand.position = tar

    
    pass

func dash():
    dashing = true
    set_collision_layer_value(1, false)
    set_collision_mask_value(1, false)
    hitBox.set_collision_layer_value(5, false)
    hitBox.set_collision_mask_value(5, false)
    dashTimer = dashTime
    if (direction == Vector2.ZERO):
        if (sprite.flip_h):
            direction = Vector2(1, 0)
        else:
            direction = Vector2(-1, 0)
    pass
func checkDash(delta):
    dashTimer -= delta
    if (dashTimer <= 0):
        set_collision_layer_value(1, true)
        set_collision_mask_value(1, true)
        hitBox.set_collision_layer_value(5, true)
        hitBox.set_collision_mask_value(5, true)
        dashing = false
        velocity = Vector2.ZERO

func die():
    dead = true
    print("DEAD")
    sprite.play("dead")
    pass

func tutorialValues():
    print("TUTORIAL VALS")
    speedMod = 0.5
    tutorial = true
    hand.visible = false
    health.visible = false

func disable():
    disabled = true

func enable():
    disabled = false

