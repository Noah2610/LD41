## This class is deprecated (didn't really do much anyway)

class Entity < Instance
	def initialize args = {}
		@z_index    ||= args[:z] || args[:z_index] || SETTINGS.entity_defaults(:z_index)
		@image ||= File.join DIR[:images], 'Entity.png'
		super
	end

	def update
		super
	end

	def draw
		super
	end
end
