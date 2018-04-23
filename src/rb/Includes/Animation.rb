module Animation
	def initialize args = {}
		super
		setup_animation
	end

	def setup_animation
		size                              = get_size
		first_image                       = @images.first
		x_multiplier                      = get_scale_x_multiplier || 1
		@scale                            = {
			x: ((size[:width].to_f  / first_image.width.to_f) * x_multiplier).round,
			y: (size[:height].to_f / first_image.height.to_f)
		}
		@current_image_counter            = 0
		@next_animation_image_change_time = Time.now.to_f + @animation_delay
	end

	def get_scale_x_multiplier
		side = get_side
		return  1  if (side == :left)
		return -1  if (side == :right)
		return  1
	end

	def get_current_image
		return @images[get_current_image_counter]
	end

	def get_current_image_counter
		return @current_image_counter
	end

	def set_next_image
		@current_image_counter += 1
		@current_image_counter  = 0  if (get_current_image.nil?)
	end

	def update
		handle_next_image
		super
	end

	def handle_next_image
		if (next_image?)
			set_next_image
			@next_animation_image_change_time = Time.now.to_f + @animation_delay
		end
	end

	def next_image?
		now = Time.now.to_f
		return now >= @next_animation_image_change_time
	end

	def draw
		pos  = get_position_to_draw
		size = get_size
		get_current_image.draw(
			pos[:x], pos[:y], get_z_index,
			@scale[:x], @scale[:y]
		)
		super
	end
end
