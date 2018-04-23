def get_resources
	return {
		images: {
			background: Gosu::Image.new(
				File.join(DIR[:images], 'Background.png'),
				GOSU_IMAGE_OPTIONS
			),
			fort:       Gosu::Image.new(
				File.join(DIR[:images], 'Fort/Fort_0.png'),
				GOSU_IMAGE_OPTIONS
			),
			enemies: {
				normal:   load_images_from_directory(File.join DIR[:images], 'Enemies/Normal'),
				big:      load_images_from_directory(File.join DIR[:images], 'Enemies/Big'),
				wizard:   load_images_from_directory(File.join DIR[:images], 'Enemies/Wizard'),
				zombie:   load_images_from_directory(File.join DIR[:images], 'Enemies/Zombie')
			}
		},
		audio: {
			beats:      load_audio_from_directory(File.join DIR[:audio], 'Beats')
		},
		fonts: {
			debug:      Gosu::Font.new(
				24,
				name: File.join(DIR[:fonts], 'Ubuntu.ttf')
			),
			prompt:     Gosu::Font.new(
				SETTINGS.prompt(:font_size),
				name: File.join(DIR[:fonts], 'ProggySquareSZ/ProggySquareSZ.ttf')
			),
			score:      Gosu::Font.new(
				SETTINGS.score(:font_size),
				name: File.join(DIR[:fonts], 'Ubuntu.ttf')
			),
			game_over: {
				text:     Gosu::Font.new(
					SETTINGS.game(:fonts)[:game_over_text][:size],
					name: File.join(DIR[:fonts], 'Ubuntu.ttf')
				),
				scores:   Gosu::Font.new(
					SETTINGS.game(:fonts)[:game_over_scores][:size],
					name: File.join(DIR[:fonts], 'Ubuntu.ttf')
				)
			}
		}
	}
end
