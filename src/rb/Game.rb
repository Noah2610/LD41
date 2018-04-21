class Game < Gosu::Window
	def initialize
		setup
		super @size[:width], @size[:height]
		self.caption = 'LD41 Jam Entry!'
	end

	# Called upon instantiation
	def setup
		set_window_size
		@colors = SETTINGS.game(:colors)
	end

	# Called when game starts
	def init
		set_fort
	end

	def set_window_size
		@size = SETTINGS.window(:size).keys_to_sym
	end

	def set_fort
		@fort = Fort.new
	end

	def get_center_position target = :all
		size = get_window_size
		return nil                         if (!size)
		return (size[target] * 0.5).round  if (size[target])
		return {
			x: (size[:width]  * 0.5).round,
			y: (size[:height] * 0.5).round
		}  if (target == :all)
	end

	def get_window_size target = :all
		return nil                         if (!@size)
		return @size[target]               if (@size[target])
		return {
			width:  get_window_size(:width),
			height: get_window_size(:height)
		}  if (target == :all)
		return nil
	end

	def update
		@fort.update
	end

	def draw
		draw_background
		@fort.draw
	end

	def draw_background

	end
end

SETTINGS = Settings.new
GAME     = Game.new
GAME.init
LOGGER.info 'Game started'
GAME.show
LOGGER.info 'Exitted naturally'
