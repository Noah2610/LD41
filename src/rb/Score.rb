class Score
	SEMANTIC_TIME_FORMAT      = '%M:%S.%3N'  # '%3N' == milliseconds
	SEMANTIC_TIME_FORMAT_LONG = '%H:%M:%S.%3N'
	UPDATE_SCORE_INTERVAL     = 4            # 30 would be about every half second, at 60 fps

	def initialize
		@start_time      = nil
		@font            = RESOURCES[:fonts][:score]
		@text_padding    = SETTINGS.score :text_padding
		@colors          = SETTINGS.score :colors
		@z_indexes       = SETTINGS.score :z_indexes
		@background_size = SETTINGS.score :background_size
	end

	def init
		@start_time = Time.now
	end

	def set_score
		return nil  if (@start_time.nil?)
		@score = get_time_diff
	end

	def get_time_diff
		now  = Time.now
		diff = now.to_f - @start_time.to_f
		new  = Time.new(0).to_f + diff
		return Time.at(new)
	end

	def update
		set_score  if (GAME.get_tick % UPDATE_SCORE_INTERVAL == 0)
	end

	def draw
		draw_background
		draw_foreground
	end

	def draw_background
		size     = get_background_size
		position = {
			x: ((GAME.get_size(:width) - @text_padding) - size[:width]),
			y: @text_padding
		}
		color    = get_color   :background
		z_index  = get_z_index :background
		Gosu.draw_rect(
			position[:x], position[:y],
			size[:width], size[:height],
			color,
			z_index
		)
	end

	def draw_foreground
		text     = get_semantic_score
		return  if (text.nil?)
		position = {
			x: (GAME.get_size(:width) - @text_padding),
			y: @text_padding
		}
		color    = get_color   :foreground
		z_index  = get_z_index :foreground
		@font.draw_rel(
			text,
			position[:x], position[:y], z_index,
			1, 0,
			1, 1,
			color
		)
	end

	def get_background_size target = :all
		return @background_size[target]  if (!!@background_size[target])
		return {
			width:  @background_size[:width],
			height: @background_size[:height]
		}                                if (target == :all)
		return nil
	end

	def get_semantic_score
		return nil  if (get_score.nil?)
		text = get_score.strftime SEMANTIC_TIME_FORMAT       if (get_score.hour == 0)
		text = get_score.strftime SEMANTIC_TIME_FORMAT_LONG  if (get_score.hour > 0)
		text[-1] = ''
		return text
	end

	def get_score
		return @score
	end

	def get_color target = :all
		return @colors[target]     if (!!@colors[target])
		return {
			foreground: @colors[:foreground],
			background: @colors[:background]
		}                          if (target == :all)
		return nil
	end

	def get_z_index target = :all
		return @z_indexes[target]  if (!!@z_indexes[target])
		return {
			foreground: @z_indexes[:foreground],
			background: @z_indexes[:background]
		}                          if (target == :all)
		return nil
	end
end
