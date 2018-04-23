module GameOverScreen
	def draw_game_over
		draw_background
		draw_background_image
		get_fort.draw
		get_cluster_manager.draw
		draw_game_over_text
		draw_game_over_scores
	end

	def draw_game_over_text
		draw_game_over_text_background
		draw_game_over_text_text
	end

	def draw_game_over_text_background
		size     = SETTINGS.game(:fonts)[:game_over_text][:background_size]
		position = {
			x: ((get_size(:width) * 0.5) - (size[:width] * 0.5)).round,
			y: ((get_size(:height).to_f * 0.01) * 10).round
		}
		color    = SETTINGS.game(:fonts)[:game_over_text][:colors][:background]
		z_index  = SETTINGS.game(:fonts)[:game_over_text][:z_indexes][:background]
		Gosu.draw_rect(
			position[:x], position[:y],
			size[:width], size[:height],
			color,
			z_index
		)
	end

	def draw_game_over_text_text
		pos_y    = ((get_size(:height).to_f * 0.01) * 10).round
		position = {
			x: (get_size(:width) * 0.5).round,
			y: (pos_y + (pos_y.to_f * 0.5).round)
		}
		color    = SETTINGS.game(:fonts)[:game_over_text][:colors][:foreground]
		z_index  = SETTINGS.game(:fonts)[:game_over_text][:z_indexes][:foreground]
		@fonts[:game_over_text].draw_rel(
			'Game Over!',
			position[:x], position[:y], z_index,
			0.5, 0.3,
			1, 1,
			color
		)
	end

	def draw_game_over_scores
		draw_game_over_score_time
		draw_game_over_score_points
		draw_game_over_score_kills
	end

	def draw_game_over_score_time
		draw_game_over_score_time_background
		draw_game_over_score_time_text
	end

	def draw_game_over_score_time_background
		size     = SETTINGS.game(:fonts)[:game_over_scores][:background_size]
		position = {
			x: ((get_size(:width) * 0.5) - (size[:width] * 0.5)).round,
			y: get_game_over_scores_position_y.round
		}
		color    = SETTINGS.game(:fonts)[:game_over_scores][:background_color]
		z_index  = SETTINGS.game(:fonts)[:game_over_scores][:z_indexes][:background]
		Gosu.draw_rect(
			position[:x], position[:y],
			size[:width], size[:height],
			color,
			z_index
		)
	end

	def draw_game_over_score_time_text
		draw_game_over_score_time_text_name
		draw_game_over_score_time_text_score
	end

	def draw_game_over_score_time_text_name
		padding  = SETTINGS.game(:fonts)[:game_over_scores][:padding_y]
		position         = {
			x: (get_game_over_scores_position_x + padding),
			y: (get_game_over_scores_position_y + padding)
		}
		color    = SETTINGS.game(:fonts)[:game_over_scores][:foreground_colors][:name]
		z_index  = SETTINGS.game(:fonts)[:game_over_scores][:z_indexes][:foreground]
		@fonts[:game_over_scores].draw_rel(
			'Time Survived:',
			position[:x], position[:y], z_index,
			0.0, -0.2,
			1, 1,
			color
		)
	end

	def draw_game_over_score_time_text_score
		padding          = SETTINGS.game(:fonts)[:game_over_scores][:padding_y]
		background_width = SETTINGS.game(:fonts)[:game_over_scores][:background_size][:width]
		position         = {
			x: (get_game_over_scores_position_x + background_width - padding),
			y: (get_game_over_scores_position_y + padding)
		}
		color            = SETTINGS.game(:fonts)[:game_over_scores][:foreground_colors][:time]
		z_index          = SETTINGS.game(:fonts)[:game_over_scores][:z_indexes][:foreground]
		@fonts[:game_over_scores].draw_rel(
			SCORE.get_formatted_score_time,
			position[:x], position[:y], z_index,
			1, -0.2,
			1, 1,
			color
		)
	end

	def draw_game_over_score_points
		draw_game_over_score_points_background
		draw_game_over_score_points_text
	end

	def draw_game_over_score_points_background
		size     = SETTINGS.game(:fonts)[:game_over_scores][:background_size]
		padding  = SETTINGS.game(:fonts)[:game_over_scores][:padding_y]
		position = {
			x: ((get_size(:width) * 0.5) - (size[:width] * 0.5)).round,
			y: (get_game_over_scores_position_y + (size[:height] + padding)).round
		}
		color    = SETTINGS.game(:fonts)[:game_over_scores][:background_color]
		z_index  = SETTINGS.game(:fonts)[:game_over_scores][:z_indexes][:background]
		Gosu.draw_rect(
			position[:x], position[:y],
			size[:width], size[:height],
			color,
			z_index
		)
	end

	def draw_game_over_score_points_text
		draw_game_over_score_points_text_name
		draw_game_over_score_points_text_score
	end

	def draw_game_over_score_points_text_name
		padding           = SETTINGS.game(:fonts)[:game_over_scores][:padding_y]
		background_height = SETTINGS.game(:fonts)[:game_over_scores][:background_size][:height]
		position          = {
			x: (get_game_over_scores_position_x + padding),
			y: (get_game_over_scores_position_y + (padding * 2) + background_height)
		}
		color             = SETTINGS.game(:fonts)[:game_over_scores][:foreground_colors][:name]
		z_index           = SETTINGS.game(:fonts)[:game_over_scores][:z_indexes][:foreground]
		@fonts[:game_over_scores].draw_rel(
			'Points:',
			position[:x], position[:y], z_index,
			0.0, -0.2,
			1, 1,
			color
		)
	end

	def draw_game_over_score_points_text_score
		padding           = SETTINGS.game(:fonts)[:game_over_scores][:padding_y]
		background_width  = SETTINGS.game(:fonts)[:game_over_scores][:background_size][:width]
		background_height = SETTINGS.game(:fonts)[:game_over_scores][:background_size][:height]
		position          = {
			x: (get_game_over_scores_position_x + background_width - padding),
			y: (get_game_over_scores_position_y + (padding * 2) + background_height)
		}
		color             = SETTINGS.game(:fonts)[:game_over_scores][:foreground_colors][:points]
		z_index           = SETTINGS.game(:fonts)[:game_over_scores][:z_indexes][:foreground]
		@fonts[:game_over_scores].draw_rel(
			SCORE.get_semantic_score_points,
			position[:x], position[:y], z_index,
			1, -0.2,
			1, 1,
			color
		)
	end

	def draw_game_over_score_kills
		draw_game_over_score_kills_background
		draw_game_over_score_kills_text
	end

	def draw_game_over_score_kills_background
		size     = SETTINGS.game(:fonts)[:game_over_scores][:background_size]
		padding  = SETTINGS.game(:fonts)[:game_over_scores][:padding_y]
		position = {
			x: ((get_size(:width) * 0.5) - (size[:width] * 0.5)).round,
			y: (get_game_over_scores_position_y + ((size[:height] + padding) * 2)).round
		}
		color    = SETTINGS.game(:fonts)[:game_over_scores][:background_color]
		z_index  = SETTINGS.game(:fonts)[:game_over_scores][:z_indexes][:background]
		Gosu.draw_rect(
			position[:x], position[:y],
			size[:width], size[:height],
			color,
			z_index
		)
	end

	def draw_game_over_score_kills_text
		draw_game_over_score_kills_text_name
		draw_game_over_score_kills_text_score
	end

	def draw_game_over_score_kills_text_name
		padding           = SETTINGS.game(:fonts)[:game_over_scores][:padding_y]
		background_height = SETTINGS.game(:fonts)[:game_over_scores][:background_size][:height]
		position          = {
			x: (get_game_over_scores_position_x + padding),
			y: (get_game_over_scores_position_y + (padding * 3) + (background_height * 2))
		}
		color             = SETTINGS.game(:fonts)[:game_over_scores][:foreground_colors][:name]
		z_index           = SETTINGS.game(:fonts)[:game_over_scores][:z_indexes][:foreground]
		@fonts[:game_over_scores].draw_rel(
			'Enemies Killed:',
			position[:x], position[:y], z_index,
			0.0, -0.2,
			1, 1,
			color
		)
	end

	def draw_game_over_score_kills_text_score
		padding           = SETTINGS.game(:fonts)[:game_over_scores][:padding_y]
		background_width  = SETTINGS.game(:fonts)[:game_over_scores][:background_size][:width]
		background_height = SETTINGS.game(:fonts)[:game_over_scores][:background_size][:height]
		position          = {
			x: (get_game_over_scores_position_x + background_width - padding),
			y: (get_game_over_scores_position_y + (padding * 3) + (background_height * 2))
		}
		color             = SETTINGS.game(:fonts)[:game_over_scores][:foreground_colors][:kills]
		z_index           = SETTINGS.game(:fonts)[:game_over_scores][:z_indexes][:foreground]
		@fonts[:game_over_scores].draw_rel(
			SCORE.get_semantic_score_kills,
			position[:x], position[:y], z_index,
			1, -0.2,
			1, 1,
			color
		)
	end

	def get_game_over_scores_position_x
		background_width = SETTINGS.game(:fonts)[:game_over_scores][:background_size][:width]
		return ((get_size(:width) * 0.5) - (background_width * 0.5)).round
	end

	def get_game_over_scores_position_y
		return (get_size(:height).to_f * 0.01) * 30
	end
end
