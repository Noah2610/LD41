class Fort < Instance
	include Health
	include HealthBar
	include Animation

	def initialize args = {}
		setup
		super
	end

	def setup
		@size              = SETTINGS.fort(:size)
		@position          = GAME.get_center_position
		@z_index           = SETTINGS.fort(:z_index)
		@align             = :center
		animation_settings = SETTINGS.fort(:animation)
		sorted_image_keys  = animation_settings[:image_order].map { |x| x.to_s.to_sym }
		@images            = RESOURCES[:images][:fort].to_sorted_a sorted_image_keys
		@animation_delay   = animation_settings[:delay]
		setup_health
		setup_lines
	end

	def setup_health
		@max_health = SETTINGS.fort(:max_health) || 100
		@health     = SETTINGS.fort(:health)     || 100
		setup_health_bar
	end

	def setup_health_bar
		health_bar_settings =         SETTINGS.fort(:health_bar)
		set_health_bar_position       health_bar_settings[:relative_position]
		set_health_bar_size           health_bar_settings[:relative_size]
		set_health_bar_colors         health_bar_settings[:colors]
		set_health_bar_z_indexes      health_bar_settings[:z_indexes]
		set_health_bar_border_padding health_bar_settings[:border_padding]
		set_health_bar_align          :center
	end

	def setup_lines
		offset_x = SETTINGS.lines(:x_offset)
		left_position = {
			x: (get_left_boundary - offset_x),
			y: get_position(:y)
		}
		right_position = {
			x: (get_right_boundary + offset_x),
			y: get_position(:y)
		}
		@lines = [
			Line.new(
				position: left_position
			),
			Line.new(
				position: right_position
			)
		]
	end

	def get_lines
		return @lines || []
	end

	def damage_by amount
		decrease_health_by amount
	end

	def destroy!
		GAME.game_over
	end

	def handle_key_down key_id
		GAME.get_cluster_manager.get_active_enemies.each do |enemy|
			enemy.handle_key_down key_id
		end
	end

	def update
		super
		update_lines
	end

	def update_lines
		get_lines.each &:update
	end

	def draw
		super
		draw_health_bar
		draw_lines
	end

	def draw_lines
		get_lines.each &:draw
	end
end
