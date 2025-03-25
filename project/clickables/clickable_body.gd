extends TextureButton


@export var clickable: Clickable
 

func _ready():
	_set_texture(clickable.default_texture)


func _set_texture(new_texture):
	texture_normal = new_texture
