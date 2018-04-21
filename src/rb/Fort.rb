class Fort < Instance
	include Health
	include HealthBar
	include Texture

	def initialize args = {}
		setup
		super args
	end

	def setup
		@size           = SETTINGS.fort(:size)
		@position       = GAME.get_center_position
		@z_index        = SETTINGS.fort(:z_index)
		@align          = :center
		@image_resource = RESOURCES[:images][:fort]
		setup_health
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

	def damage_by amount
		decrease_health_by amount
	end

	def destroy!
		GAME.game_over
	end

	def update
		super
	end

	def draw
		super
		draw_health_bar
	end
end
