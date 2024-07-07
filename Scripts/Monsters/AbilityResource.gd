class_name AbilityResource extends Resource

@export var name: String
@export var description: String
@export_enum("HEAL", "BOOST", "DAMAGE") var type = "HEAL"
@export var amount = 10
