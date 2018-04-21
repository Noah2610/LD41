class Instance
	def initialize args = {}
		@position ||= args[:position]
		@size     ||= args[:size]
		@z_index  ||= args[:z] || args[:z_index] || SETTINGS.instance_defaults(:z_index)
		@color    ||= args[:color] || SETTINGS.instance_defaults(:color)
		@align    ||= :top_left
	end

	def get_position target = :all
		return nil                if (!@position)
		return @position[target]  if (@position[target])
		return {
			x: get_position(:x),
			y: get_position(:y)
		}  if (target == :all)
		return nil
	end

	def get_position_to_draw
		case @align
		when :center
			return get_position_to_draw_for_center
		when :top_left
			return get_position_to_draw_for_top_left
		when :top_right
			return get_position_to_draw_for_top_right
		when :bottom_left
			return get_position_to_draw_for_bottom_left
		when :bottom_right
			return get_position_to_draw_for_bottom_right
		else
			return get_position
		end
	end

	def get_position_to_draw_for_center
		position = get_position
		size     = get_size
		return get_offset_position_of({
			x: (position[:x] - (size[:width] * 0.5)).round,
			y: (position[:y] - (size[:height] * 0.5)).round
		})
	end

	def get_position_to_draw_for_top_left
		return get_offset_position_of get_position
	end

	def get_position_to_draw_for_top_right
		position = get_position
		size     = get_size
		return get_offset_position_of({
			x: (position[:x] - size[:width]),
			y: position[:y]
		})
	end

	def get_position_to_draw_for_bottom_left
		position = get_position
		size     = get_size
		return get_offset_position_of({
			x: position[:x],
			y: (position[:y] - size[:height])
		})
	end

	def get_position_to_draw_for_bottom_right
		position = get_position
		size     = get_size
		return get_offset_position_of({
			x: (position[:x] - size[:width]),
			y: (position[:y] - size[:height])
		})
	end

	def get_offset_position_of position
		offset = GAME.get_canvas_offset
		ret = {
			x: position[:x] + offset[:x],
			y: position[:y] + offset[:y]
		}
		return ret
	end

	def get_size target = :all
		return nil                if (!@size)
		return @size[target]      if (@size[target])
		return {
			width:  get_size(:width),
			height: get_size(:height)
		}  if (target == :all)
		return nil
	end

	def get_z_index
		return @z_index
	end

	def get_color
		return @color
	end

	def get_boundary target = :all
		case target
		when :all
			return {
				top:    get_boundary(:top),
				bottom: get_boundary(:bottom),
				left:   get_boundary(:left),
				right:  get_boundary(:right)
			}
		when :top,    :upper
			return get_top_boundary
		when :bottom, :lower
			return get_bottom_boundary
		when :left
			return get_left_boundary
		when :right
			return get_right_boundary
		end
	end

	def get_boundaries *targets
		return targets.map do |target|
			next [target, get_boundary(target)]
		end .to_h
	end

	def get_top_boundary
		return get_position_to_draw[:y]
	end

	def get_bottom_boundary
		return get_position_to_draw[:y] + get_size(:height)
	end

	def get_left_boundary
		return get_position_to_draw[:x]
	end

	def get_right_boundary
		return get_position_to_draw[:x] + get_size(:width)
	end

	def update
	end

	def draw
	end
end
