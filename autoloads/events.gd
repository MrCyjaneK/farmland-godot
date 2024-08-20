extends Node


## Emitted when the UI should be updated. <br>
## This is useful to update info related to the player.
@warning_ignore("unused_signal")
signal ui_updated()
## Emitted when the wallet wants to change the current scene.
@warning_ignore("unused_signal")
signal wallet_screen_changed(scene: PackedScene)
