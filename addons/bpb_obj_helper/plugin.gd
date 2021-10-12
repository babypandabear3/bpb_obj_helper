tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("BPB_Obj_helper", "MeshInstance", preload("obj_helper.gd"), preload("icon.png"))
	set_input_event_forwarding_always_enabled()

func _exit_tree():
	remove_custom_type("BPB_Obj_helper")

func forward_spatial_gui_input(camera, event):
	#KEYBOARD SHORTCUT
	if event is InputEventKey :
		if event.is_pressed():
			if event.scancode == KEY_F4:
				if event.control:
					pass
				elif event.alt:
					pass
				elif event.shift:
					pass
				else:
					try_update_everything()
					
func try_update_everything():
	var root = get_tree().get_edited_scene_root()
	recursive_update(root)
	
func recursive_update(parent_node):
	for o in parent_node.get_children():
		recursive_update(o)
	if parent_node is BPB_Obj_helper:
		parent_node.update_mesh()
