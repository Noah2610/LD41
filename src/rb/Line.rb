class Line < Instance
	include Rectangle
	include Collision

	def initialize args = {}
		setup
		super
	end

	def setup
		lines_settings    = SETTINGS.lines
		@size  = {
			width:            lines_settings[:width],
			height:           GAME.get_size(:height)
		}
		@color            = lines_settings[:color]
		@z_index          = lines_settings[:z_index]
		@align            = :center
	end

	def update
		handle_collision
		super
	end

	def handle_collision
		@can_collide_with  = GAME.get_cluster_manager.get_enemies
		colliding_previous = get_colliding
		if (collision?)
			get_colliding.each      &:activate_prompt
		else
			colliding_previous.each &:deactivate_prompt
		end
	end

	def draw
		super
	end
end
