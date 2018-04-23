module Texture
	def initialize args = {}
		super
		setup_texture
	end

	def setup_texture
		size   = get_size
		x_multiplier = get_scale_x_multiplier || 1
		@scale = {
			x: ((size[:width].to_f  / @image.width.to_f) * x_multiplier).round,
			y: (size[:height].to_f / @image.height.to_f)
		}
	end

	def get_scale_x_multiplier
		side = get_side
		return  1  if (side == :left)
		return -1  if (side == :right)
		return  1
	end

	def draw
		pos  = get_position_to_draw
		size = get_size
		@image.draw(
			pos[:x], pos[:y], get_z_index,
			@scale[:x], @scale[:y]
		)
		super
	end
end
