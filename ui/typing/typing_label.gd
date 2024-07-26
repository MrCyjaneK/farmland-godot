extends RichTextLabel


## Emitted when the word was typed correctly.
signal correct()
## Emitted when the word was typed wrong.
signal wrong(character: int, actual: String, expected: String)

@export var correct_color := Color.GREEN
@export var pending_color := Color.WHITE
## Treat the answer case sensitive.
@export var case_sensitive := false

## The full text to be typed.
var prompt := ""
## The answer being typed in.
var answer := ""
## The character to be typed.
var char_index := 0
## The bank of words available.
var words := []
## The preferred word length. -1 for none.
var preferred_length := -1


func _ready() -> void:
	var word_bank = []
	var path = "res://common/word_list/words.txt"
	
	if FileAccess.file_exists(path):
		var f = FileAccess.open(path, FileAccess.READ)
		var err = f.get_error()
		
		if err == OK:
			while not f.eof_reached():
				var line = f.get_line()
				
				if line:
					word_bank.append(line)
		else:
			push_error("Error when reading file %s (%d)" % [path, err])
	
	start(word_bank)


func start(_words: PackedStringArray) -> void:
	assert(not _words.is_empty(), "the word bank is empty")
	words = _words
	_next_word()


## Skips to the next word.
func _next_word() -> void:
	var current_word = prompt
	
	if preferred_length > 0:
		while prompt == current_word or prompt.length() != preferred_length:
			prompt = words.pick_random()
	else:
		while prompt == current_word:
			prompt = words.pick_random()
	
	answer = ""
	char_index = 0
	update()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var key_typed = PackedByteArray([event.unicode]).get_string_from_utf8()
		
		if key_typed:
			get_viewport().set_input_as_handled()
			var is_correct := true
			
			if case_sensitive:
				is_correct = prompt[char_index] == key_typed
			else:
				is_correct = prompt[char_index].to_lower() == key_typed.to_lower()
			
			if is_correct:
				# It was the right character
				answer += prompt[char_index]
				char_index += 1
				update()
			else:
				# It was the wrong character
				wrong.emit(char_index, key_typed, prompt[char_index])
				_next_word()
			
			if answer.length() == prompt.length():
				correct.emit()
				_next_word()


func update() -> void:
	text = "[color=%s]%s[/color][color=%s]%s[/color]" % [correct_color.to_html(), answer, pending_color.to_html(), prompt.substr(char_index)]
