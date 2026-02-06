extends Node2D

export(String) var banana_id
export(float) var spawn_timer = 20.0

var has_been_colected := false
var time_left := 0.0
var disappear_time := 0

func _ready():
	banana_id = self.name
	
	$AnimationPlayer.play("idle")
	define_banana_state()

func define_banana_state():
	if GlobalValues.bananas_dictionary_save.has(banana_id):
		var data = GlobalValues.bananas_dictionary_save[banana_id]

		if data["been_collected"]:
			has_been_colected = true
			time_left = data["time_left"]

			$Sprite.visible = false
			$Light2D.visible = false
			$Area2D/CollisionShape2D.set_deferred("disabled", true)

			start_banana_timer(time_left)

func _on_Area2D_body_entered(body):
	if body.name == "Moggy" and not has_been_colected:
		dissapear_banana()

func dissapear_banana():
	has_been_colected = true
	disappear_time = OS.get_unix_time()
	time_left = spawn_timer

	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	GlobalValues.golden_bananas_amount += 1

	$Sprite.visible = false
	$Light2D.visible = false
	$FADE.play("FADE")

	start_banana_timer(time_left)
	
	$GlobalSoundEffectGenerator.play_sound("banana_collected_sound_effect")

	SaveSystem.save_game()
	
func start_banana_timer(time):
	var timer = get_tree().create_timer(time)
	yield(timer, "timeout")
	appear_banana()


func appear_banana():
	has_been_colected = false

	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	$Sprite.visible = true
	$Light2D.visible = true
	$FADE.play_backwards("FADE")


func save_banana_stats():
	if has_been_colected:
		var elapsed = OS.get_unix_time() - disappear_time
		time_left = max(spawn_timer - elapsed, 0)

		GlobalValues.bananas_dictionary_save[banana_id] = {
			"been_collected": true,
			"time_left": time_left
		}
	else:
		GlobalValues.bananas_dictionary_save[banana_id] = {
			"been_collected": false,
			"time_left": 0
		}


func _on_BananPoints_tree_exited():
	save_banana_stats()
