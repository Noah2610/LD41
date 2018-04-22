class Game < Gosu::Window
	def initialize
		setup
		super @size[:width], @size[:height]
		self.caption = SETTINGS.window(:title)
		#TODO: REMOVE
		@font = Gosu::Font.new 24
		#self.update_interval = 30.0
	end

	# Called upon instantiation
	def setup
		set_window_size
		@colors             = SETTINGS.game(:colors)
		@background_z_index = SETTINGS.game(:background_z_index)
		@cluster_manager    = ClusterManager.new
	end

	def set_window_size
		@size = SETTINGS.window(:size).keys_to_sym
	end

	def init_game
		@running = true
		set_fort
		get_cluster_manager.init
	end

	def set_fort
		@fort = Fort.new
	end

	def get_center_position target = :all
		size = get_size
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

	def get_size target = :all
		#TODO:
		## Change up this method if game will get a panel at the top or so
		return get_offset_size target
	end

	def get_offset_size target
		size = get_window_size
		return nil                                       if (!size)
		return size[target] + get_canvas_offset(target)  if (size[target])
		return {
			width:  get_offset_size(:width),
			height: get_offset_size(:height)
		}  if (target == :all)
		return nil
	end

	def get_canvas_offset target = :all
		#TODO:
		## Add offsets here when necessary
		target = :x  if (target == :width)
		target = :y  if (target == :height)
		offset = { x: 0, y: 0 }
		return offset[target]  if (offset[target])
		return {
			x: get_canvas_offset(:x),
			y: get_canvas_offset(:y)
		}  if (target == :all)
		return nil
	end

	def get_z_index
		return @background_z_index
	end

	def get_fort
		return @fort
	end

	def game_over
		puts "GAME OVER"
		@running = false
	end

	def button_down key_id
		#char = Gosu.button_id_to_char key_id
		exit  if (key_id == Gosu::KB_ESCAPE)
	end

	def needs_cursor?
		return true
	end

	def update
		return  unless (is_running?)
		get_fort.update
		get_cluster_manager.update
	end

	def get_cluster_manager
		return @cluster_manager
	end

	def is_running?
		return !!@running
	end

	def draw
		return  unless (is_running?)
		draw_background
		get_fort.draw
		get_cluster_manager.draw
		#TODO: REMOVE
		draw_fps
	end

	def draw_background
		size = get_window_size
		Gosu.draw_rect(
			0, 0,
			size[:width], size[:height],
			@colors[:background],
			get_z_index
		)
	end

	#TODO: REMOVE
	def draw_fps
		pos = {
			x: 32,
			y: 32
		}
		Gosu.draw_rect(
			0, 0,
			pos[:x], pos[:y],
			@colors[:background],
			100
		)
		@font.draw_rel(
			Gosu.fps,
			pos[:x] * 0.5, pos[:y] * 0.5, 110,
			0.5, 0.5,
			1, 1,
			0xff_000000
		)
	end
end

SETTINGS = Settings.new
GAME     = Game.new
GAME.init_game
LOGGER.info 'Game started'
GAME.show
LOGGER.info 'Exitted naturally'
