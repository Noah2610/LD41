module Texture
	def initialize args = {}
		super
		load_image
	end

	def load_image
		@image = @image_resource
		size   = get_size
		@scale = {
			x: (size[:width].to_f  / @image.width.to_f),
			y: (size[:height].to_f / @image.height.to_f)
		}
	end

	def draw
		pos  = get_position_to_draw
		size = get_size
		if (pos.nil?)
			LOGGER.warning "Error getting position from Texture#draw"
			return
		end
		@image.draw(
			pos[:x], pos[:y], get_z_index,
			@scale[:x], @scale[:y]
		)
		super
	end
end
