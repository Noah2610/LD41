module Rectangle
	def update
	end

	def draw
		position = get_position_to_draw
		size     = get_size
		Gosu.draw_rect(
			position[:x], position[:y],
			size[:width], size[:height],
			get_color,
			get_z_index
		)
	end
end
