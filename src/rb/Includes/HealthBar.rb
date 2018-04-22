## This module should definitely be a class, inheriting from Instance...
## Now it's basically a copy/pasted Instance with custom stuff

module HealthBar
	def set_health_bar_position position
		@health_bar_position_relative = position
	end

	def set_health_bar_size size
		@health_bar_size_relative     = size
	end

	def set_health_bar_colors colors
		@health_bar_colors            = colors
	end

	def set_health_bar_z_indexes z_indexes
		@health_bar_z_index           = z_indexes
	end

	def set_health_bar_border_padding border_padding
		@health_bar_border_padding    = border_padding
	end

	def set_health_bar_align align
		@health_bar_align             = align
	end

	def draw_health_bar
		return  unless (health_bar_position = get_health_bar_position)
		position = get_health_bar_position_to_draw
		size     = get_health_bar_size
		draw_health_bar_background position: position, size: size
		draw_health_bar_inner      position: position, size: size
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

	def draw_health_bar_inner args = {}
		position    = get_health_bar_inner_position(args[:position] || get_health_bar_position)
		size        = get_health_bar_inner_size(    args[:size]     || get_health_bar_size)
		Gosu.draw_rect(
			position[:x], position[:y],
			size[:width], size[:height],
			get_health_bar_color(:foreground),
			get_health_bar_z_index(:foreground)
		)
	end

	def get_health_bar_inner_position position
		padding = get_health_bar_border_padding
		return {
			x: (position[:x] + padding[:x]),
			y: (position[:y] + padding[:y])
		}
	end

	def get_health_bar_inner_size size
		padding   = get_health_bar_border_padding
		full_size = {
			width:  (size[:width]  - (padding[:x] * 2)),
			height: (size[:height] - (padding[:y] * 2))
		}
		return full_size  if (has_max_health?)
		health = get_health
		return {
			width:  (full_size[:width] * (health.to_f / get_max_health.to_f)),
			height: full_size[:height]
		}
	end

	def get_health_bar_position_to_draw
		case @health_bar_align
		when :center
			return get_health_bar_position_to_draw_for_center
		when :top_left
			return get_health_bar_position_to_draw_for_top_left
		when :top_right
			return get_health_bar_position_to_draw_for_top_right
		when :bottom_left
			return get_health_bar_position_to_draw_for_bottom_left
		when :bottom_right
			return get_health_bar_position_to_draw_for_bottom_right
		else
			return get_health_bar_position
		end
	end

	def get_health_bar_position_to_draw_for_center
		position = get_health_bar_position
		size     = get_health_bar_size
		return {
			x: (position[:x] - (size[:width] * 0.5)).round,
			y: (position[:y] - (size[:height] * 0.5)).round
		}
	end

	def get_health_bar_position_to_draw_for_top_left
		return get_offset_position_of get_health_bar_position
	end

	def get_health_bar_position_to_draw_for_top_right
		position = get_health_bar_position
		size     = get_health_bar_size
		return {
			x: (position[:x] - size[:width]),
			y: position[:y]
		}
	end

	def get_health_bar_position_to_draw_for_bottom_left
		position = get_health_bar_position
		size     = get_health_bar_size
		return {
			x: position[:x],
			y: (position[:y] - size[:height])
		}
	end

	def get_health_bar_position_to_draw_for_bottom_right
		position = get_health_bar_position
		size     = get_health_bar_size
		return {
			x: (position[:x] - size[:width]),
			y: (position[:y] - size[:height])
		}
	end

	def get_health_bar_position target = :all
		size_target = (target == :x) ? :width : ((target == :y) ? :height : :all)
		position    = get_position_to_draw[target]
		size        = get_size size_target
		return (position + (size * @health_bar_position_relative[target])).round  if (!!@health_bar_position_relative[target])
		return {
			x: get_health_bar_position(:x),
			y: get_health_bar_position(:y)
		}  if (target == :all)
		return nil
	end

	def get_health_bar_size target = :all
		if (!!@health_bar_size_relative[target])
			size = get_size target
			return (size * @health_bar_size_relative[target]).round
		end
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

	def get_health_bar_border_padding target = :all
		return @health_bar_border_padding[target]  if (@health_bar_border_padding[target])
		return {
			x: get_health_bar_border_padding(:x),
			y: get_health_bar_border_padding(:y)
		}  if (target == :all)
	end
end
