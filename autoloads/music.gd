extends AudioStreamPlayer


## Plays the given [code]music[/code] resource.
func play_music(music: MusicStream) -> void:
	if music and music.stream and stream != music.stream:
		stream = music.stream
		volume_db = linear_to_db(music.volume)
		pitch_scale = music.pitch_scale
		play()
