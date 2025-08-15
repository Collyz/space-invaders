extends GPUParticles2D

func _ready():
	self.amount = 50000
	
	var screen_size = get_viewport_rect().size
	var mat := self.process_material as ParticleProcessMaterial
	if mat:
		mat.emission_ring_radius = screen_size.y
		mat.emission_ring_inner_radius = screen_size.x / 2.5
