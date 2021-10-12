tool
extends MeshInstance

class_name BPB_Obj_helper

export (bool) var refresh = false setget refresh_set
export (String, FILE, "*.obj") var obj_file = "" setget obj_file_set

var mesh_obj

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func obj_file_set(file_path):
	if file_path == null:
		file_path = ""
	obj_file = file_path
	update_mesh()
	
func update_mesh():
	var file = File.new()
	if file.file_exists(obj_file):
		mesh_obj = load(obj_file)
		mesh = mesh_obj
		
		for o in get_children():
			if o is StaticBody:
				o.free()
				
		create_trimesh_collision()
		var mat = load("res://addons/bpb_obj_helper/grid-triplanar.material")
		material_override = mat
		print("BPB OBJ HELPER : Mesh and Collision are updated")
		
func refresh_set(value):
	if value:
		update_mesh()
		refresh = false

