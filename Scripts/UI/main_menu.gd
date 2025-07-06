extends Control


func _ready() -> void:
	$PanelContainer2.visible = false
	$VideoJamesContainer.visible = false

func _on_exit_button_pressed() -> void:
	$PanelContainer2.visible = true


func _on_video_james_button_pressed() -> void:
	$VideoJamesContainer.visible = true
	$PanelContainer2.visible = false
	$VideoJamesContainer/Panel2/antjaVideo.play()

func _on_antja_video_finished() -> void:
	$VideoJamesContainer/Panel2/antjaVideo.play()
	$VideoJamesContainer/Panel2/antjaVideo.paused = true
	
