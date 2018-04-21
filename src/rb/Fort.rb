class Fort < Instance
	include Texture

	def initialize args = {}
		setup
		super args
	end

	def setup
		@size       = SETTINGS.fort(:size).keys_to_sym
		@position   = GAME.get_center_position
		@z_index    = SETTINGS.fort(:z_index)
		@align      = :center
		@image_file = File.join DIR[:images], 'Fort.png'
	end

	def update
		super
	end

	def draw
		super
	end
end
