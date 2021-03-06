class Prompt < Instance
	include Health
	include HealthBar

	def initialize args = {}
		setup args
		super
	end

	def setup args = {}
		@enemy             = args[:enemy]
		@amount_of_keys    = args[:amount_of_keys] || 1
		@align             = get_enemy.get_align
		@active            = false
		@font              = RESOURCES[:fonts][:prompt]
		prompt_settings    = SETTINGS.prompt
		@size              = prompt_settings[:size]
		@position_y_offset = prompt_settings[:y_offset]   if (!!prompt_settings[:y_offset])
		@colors            = prompt_settings[:colors]     if (!!prompt_settings[:colors])
		@z_indexes         = prompt_settings[:z_indexes]  if (!!prompt_settings[:z_indexes])
		setup_health
		set_random_keys
		set_health
	end

	def setup_health
		@max_health = get_enemy.get_max_health
		@health     = get_enemy.get_health
		setup_health_bar
	end

	def setup_health_bar
		health_bar_settings =         SETTINGS.enemies(:health_bar)
		set_health_bar_position       health_bar_settings[:relative_position]
		set_health_bar_size           health_bar_settings[:relative_size]
		set_health_bar_colors         health_bar_settings[:colors]
		set_health_bar_z_indexes      health_bar_settings[:z_indexes]
		set_health_bar_border_padding health_bar_settings[:border_padding]
		set_health_bar_align          :bottom_left
	end

	def set_random_keys
		@keys = []
		@amount_of_keys.times do
			@keys << SETTINGS.get_available_prompt_keys.sample
		end
	end

	def set_health
		@health     = get_keys.size
		@max_health = @health.dup
	end

	def get_keys
		return @keys || []
	end

	def activate!
		@active = true
	end

	def deactivate!
		@active = false
	end

	def active?
		return !!@active
	end

	def inactive?
		return !active?
	end

	def handle_key_down key_id
		return        if (inactive?)
		attack_enemy  if (proper_key_id? key_id)
	end

	def proper_key_id? key_id
		char = Gosu.button_id_to_char(key_id).upcase
		return char == get_keys.last
	end

	def attack_enemy
		@keys.delete_at -1
		decrease_health_by 1
	end

	def destroy!
		get_enemy.kill!
	end

	def update
		update_position
	end

	def update_position
		@position[:x] = get_enemy.get_position(:x)
		@position[:y] = get_enemy.get_position(:y) - get_position_y_offset - get_size(:height)
	end

	def get_position_y_offset
		return @position_y_offset || 0
	end

	def get_enemy
		return @enemy
	end

	def draw
		draw_background
		draw_keys
		draw_health_bar
	end

	def draw_background
		position = get_position_to_draw
		size     = get_size
		color    = get_color   :background
		z_index  = get_z_index :background
		Gosu.draw_rect(
			position[:x], position[:y],
			size[:width], size[:height],
			color,
			z_index
		)
	end

	def get_z_index target = :all
		return @z_indexes[target]  if (!!@z_indexes[target])
		return @z_indexes          if (target == :all)
		return nil
	end

	def get_color target = :all
		colors = get_colors_for_activation_state
		return colors[target]     if (!!colors[target])
		return colors             if (target == :all)
		return nil
	end

	def get_colors_for_activation_state
		return @colors[:active]    if (active?)
		return @colors[:inactive]  if (inactive?)
		return nil
	end

	def draw_keys
		text     = get_text_from_keys
		position = get_position
		z_index  = get_z_index :foreground
		color    = get_color   :foreground
		@font.draw_rel(
			text,
			position[:x], position[:y], z_index,
			0.5, 0.45,
			1, 1,
			color
		)
	end

	def get_text_from_keys
		return get_keys.reverse.join('')
	end
end
