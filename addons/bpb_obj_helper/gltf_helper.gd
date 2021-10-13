tool
extends Spatial

class_name BPB_Gltf_helper

export (bool) var refresh = false setget refresh_set
export (String, FILE, "*.glb, *.gltf") var obj_file = "" setget obj_file_set
export (bool) var grid_tex = false setget grid_tex_set
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
		var importer :EditorSceneImporter = EditorSceneImporter.new()
		var node
		if Engine.editor_hint:
			node = importer.import_scene_from_other_importer(obj_file, 1, 30)
		else:
			node = load(obj_file).instance()
		
		for o in get_children():
			o.free()

		add_child(node)
		node.owner = self
		if grid_tex:
			apply_grid_tex(true)
		else:
			apply_grid_tex(false)
	print(name, " : meshes and collision updated")
			
func apply_grid_tex(par):
	if par:
		var mat = load("res://addons/bpb_obj_helper/grid-triplanar.material")
		recursive_apply_mat(self, mat)
	else:
		recursive_apply_mat(self, null)
	print(name, " : material updated")
		
func refresh_set(value):
	if value:
		update_mesh()
		refresh = false
		
func grid_tex_set(val):
	grid_tex = val
	apply_grid_tex(grid_tex)
	
func recursive_apply_mat(parent, mat):
	for o in parent.get_children():
		recursive_apply_mat(o, mat)
	if parent is MeshInstance:
		parent.material_override = mat
			
