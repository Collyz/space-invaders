extends GPUParticles2D


func _ready():
	self.amount = 40000
	
	var screen_size = get_viewport_rect().size
	var material := self.process_material as ParticleProcessMaterial
	if material:
		material.emission_ring_radius = screen_size.y / 2
		material.emission_ring_inner_radius = screen_size.x / 3
