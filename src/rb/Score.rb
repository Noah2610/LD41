class Score
	FORMATTED_SCORE_TIME            = '%M:%S.%3N'  # '%3N' == milliseconds
	FORMATTED_SCORE_TIME_LONG       = '%H:%M:%S.%3N'
	SEMANTIC_SCORE_TIME_FORMAT      = '%M MINUTES, %S SECONDS, and %3N MILLISECONDS'
	SEMANTIC_SCORE_TIME_FORMAT_LONG = '%H HOURS, %M MINUTES, %S SECONDS, and %3N MILLISECONDS'
	UPDATE_SCORE_TIME_INTERVAL = 4            # 30 would be about every half second, at 60 fps

	def initialize
		@scores = {
			time:   nil,
			points: 0,
			kills:  0
		}
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

	def set_score_time
		return nil  if (@start_time.nil?)
		@scores[:time] = get_time_diff
	end

	def get_time_diff
		now  = Time.now
		diff = now.to_f - @start_time.to_f
		new  = Time.new(0).to_f + diff
		return Time.at(new)
	end

	def update
		set_score_time  if (update_score_time?)
	end

	def update_score_time?
		return false  unless (GAME.is_running?)
		return (GAME.get_tick % UPDATE_SCORE_TIME_INTERVAL == 0)
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
		draw_score_time
		draw_score_points
	end

	def draw_score_time
		text     = get_formatted_score_time
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

	def draw_score_points
		text     = get_semantic_score_points
		return  if (text.nil?)
		position = {
			x: (GAME.get_size(:width) - @text_padding),
			y: (@text_padding + get_background_size(:height))
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

	def get_formatted_score_time
		return nil  if (get_score_time.nil?)
		text = get_score_time.strftime FORMATTED_SCORE_TIME       if (get_score_time.hour == 0)
		text = get_score_time.strftime FORMATTED_SCORE_TIME_LONG  if (get_score_time.hour > 0)
		text[-1] = ''
		return text
	end

	def get_score_time
		return @scores[:time]
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

	def get_semantic_score_points
		points = get_score_points.round
		text   = "#{points} Pts."
		return text
	end

	def get_score_points
		return @scores[:points]
	end

	def increase_score_points_by points
		@scores[:points] += get_points_with_difficulty points
	end
	alias :increase_score_by :increase_score_points_by

	def get_points_with_difficulty points
		return points * DIFFICULTY.get_score_multiplier
	end

	def get_semantic_score_time
		time     = get_score_time
		if    (time.hour == 0)
			semantic = time.strftime SEMANTIC_SCORE_TIME_FORMAT
		elsif (time.hour >  0)
			semantic = time.strftime SEMANTIC_SCORE_TIME_FORMAT_LONG
		end
		words = {
# method name  to be replaced   singular       plural
			hour:    ['HOURS',        'Hour (wow)',  'HOURS (how?)'],
			min:     ['MINUTES',      'Minute',      'Minutes'],
			sec:     ['SECONDS',      'Second',      'Seconds'],
			msec:    ['MILLISECONDS', 'Millisecond', 'Milliseconds']
		}
		words.each do |meth, word_group|
			amount    = time.method(meth).call
			plurality = 1  if (amount == 1)
			plurality = 2  if (amount == 0 || amount > 1)
			semantic.sub! word_group[0], word_group[plurality]
		end
		return semantic
	end

	def increase_kill_count amount = 1
		@scores[:kills] += amount
	end

	def get_score_kills
		return @scores[:kills]
	end
end
