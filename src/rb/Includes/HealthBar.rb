module HealthBar
	def set_health_bar_position position
		@health_bar_position_relative = position
	end

	def set_health_bar_size size
		@health_bar_size              = size
	end

	def set_health_bar_colors colors
		@health_bar_colors            = colors
	end

	def set_health_bar_z_indexes z_indexes
		@health_bar_z_index           = z_indexes
	end

	def draw_health_bar
		return  unless (health_bar_position = get_health_bar_position)
		position = get_health_bar_position
		size     = get_health_bar_size
		draw_health_bar_background position: position, size: size
	end

	def draw_health_bar_background args = {}
		position = args[:position] || get_health_bar_position
		size     = args[:size]     || get_health_bar_size
		Gosu.draw_rect(
			position[:x], position[:y],
			size[:width], size[:height],
			get_health_bar_color(:background),
			get_health_bar_z_index(:background)
		)
	end

	def get_health_bar_position target = :all
		size_target = (target == :x) ? :width : ((target == :y) ? :height : :all)
		position = get_position_to_draw[target]
		size     = get_size size_target
		return position + (size * @health_bar_position_relative[target])  if (!!@health_bar_position_relative[target])
		return {
			x: get_health_bar_position(:x),
			y: get_health_bar_position(:y)
		}  if (target == :all)
		return nil
	end

	def get_health_bar_size target = :all
		return @health_bar_size[target]  if (!!@health_bar_size[target])
		return {
			width:  get_health_bar_size(:width),
			height: get_health_bar_size(:height)
		}  if (target == :all)
		return nil
	end

	def get_health_bar_color target = :all
		return @health_bar_colors[target]  if (@health_bar_colors[target])
		return {
			foreground: get_health_bar_color(:foreground),
			background: get_health_bar_color(:background)
		}  if (target == :all)
	end

	def get_health_bar_z_index target = :all
		return @health_bar_z_index[target]  if (@health_bar_z_index[target])
		return {
			foreground: get_health_bar_z_index(:foreground),
			background: get_health_bar_z_index(:background)
		}  if (target == :all)
	end
end
