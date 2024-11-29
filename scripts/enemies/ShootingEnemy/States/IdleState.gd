extends BaseEnemyState

@export var speed = 1
@export var amplitude = 5
@export var frequency = 0.1
@export var range = 100


var timeX = 0.0
var timeY = 0.0
var perlinNoise = null
var weight = 0.2

var stopped = false
var stopTime = 0.0

var opp = false

var finalDirection = Vector2()
var character = null
var speedMod = 0.3


func enter():
    character.speedMod = speedMod
    # print("changed")

func exit():
    character.speedMod = 1

func _ready():
    stateName = "idle"
    perlinNoise = FastNoiseLite.new()
    perlinNoise.noise_type = FastNoiseLite.TYPE_PERLIN
    perlinNoise.frequency = frequency

func _physics_process(delta):
    timeX += speed * delta
    timeY += speed * delta * 0.9
    var perlinX = perlinNoise.get_noise_2d(timeX, 0) 
    var perlinY = perlinNoise.get_noise_2d(0, timeY) 
    var perlinDirection = Vector2(perlinX, perlinY).normalized()
    if opp:
        perlinDirection = -perlinDirection
    
    character.perlin = perlinDirection

    var currentRange = (character.originalPos - character.global_position).length()

    finalDirection = lerp( perlinDirection, (character.originalPos - character.global_position).normalized(), (currentRange/range)/2).normalized()

    stop(delta)

    var alignment_threshold = 178
    var align = 183
    var angle_between = rad_to_deg(perlinDirection.angle_to((character.originalPos - character.global_position).normalized()))
    if abs(angle_between) > alignment_threshold && abs(angle_between) < align && (currentRange/range) > 0.9:
        # print(angle_between)
        # If the angle is very small, directly use toSpawn direction
        opp = !opp
        stopped = true
        stopTime = randf_range(0.5, 1.5)

    if stopped:
        finalDirection = Vector2.ZERO

    character.dir = finalDirection


func stop(delta):
    if (stopped):
        stopTime -= delta
        if (stopTime <= 0):
            stopped = false
    else:
        var randNum = randi() % 1000
        if (randNum <= 1):
            stopped = true
            stopTime = randf_range(1.0, 3.0)