class Fort < Instance
	include Texture

	def initialize args = {}
		setup
		image_file = File.join DIR[:art][:images], 'Fort.png'
		super ({ image: image_file }.merge( args ))
	end

	def setup
		@size     = SETTINGS.fort(:size).keys_to_sym
		@position = GAME.get_center_position
		@z_index  = 10
		@align    = :center
	end

	def update
		super
	end

	def draw
		super
	end
end
