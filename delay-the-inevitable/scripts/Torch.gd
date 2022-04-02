extends OmniLight

var noise = OpenSimplexNoise.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Configure
	noise.seed = randi()
	noise.octaves = 3
	noise.period = 1.0

func _process(delta):
	flicker()

func flicker():
	var t = OS.get_ticks_msec() / 1000.0
	light_energy = 0.75 + 0.25 * noise.get_noise_1d(t)
