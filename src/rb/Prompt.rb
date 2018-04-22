class Prompt < Instance
	def self.get_available_keys
		return (65 .. 90).map do |n|
			next n.chr
		end
	end

	AVAILABLE_KEYS = get_available_keys

	def initialize args = {}
		setup args
		super
	end

	def setup args = {}
		@enemy             = args[:enemy]
		@align             = get_enemy.get_align
		prompt_settings    = SETTINGS.prompt
		height             = (!!prompt_settings[:height]) ? prompt_settings[:height] : 24
		@size = {
			width:  get_enemy.get_size(:width),
			height: height
		}
		@position_y_offset = prompt_settings[:y_offset]   if (!!prompt_settings[:y_offset])
		@colors            = prompt_settings[:colors]     if (!!prompt_settings[:colors])
		@z_indexes         = prompt_settings[:z_indexes]  if (!!prompt_settings[:z_indexes])
		set_random_keys
	end

	def set_random_keys
		#TODO: Get amount of keys from DifficultyManager
		@keys = []
		rand(1 .. 4).times do
			@keys << AVAILABLE_KEYS.sample
		end
	end

	def get_keys
		return @keys || []
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
		return @colors[target]     if (!!@colors[target])
		return @colors             if (target == :all)
		return nil
	end
end
