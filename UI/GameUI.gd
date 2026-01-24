extends CanvasLayer


func _process(delta):
	$BananaAmountDisplay/Label.text = str(GlobalValues.golden_bananas_amount) + "x"
