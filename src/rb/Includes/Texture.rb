module Texture
	def initialize args = {}
		super
		image_file = args[:image]
		if (image_file.nil? || !File.file?(image_file))
			msg = "Module Texture received an invalid image file path! #{image_file}"
			LOGGER.fatal msg
			abort msg
		end
		load_image image_file
	end

	def load_image image_file
		@image = Gosu::Image.new image_file, retro: true
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
