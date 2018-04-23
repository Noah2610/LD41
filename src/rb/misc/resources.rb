def get_resources
	return {
		images: {
			background: Gosu::Image.new(
				File.join(DIR[:images], 'Background.png'),
				GOSU_IMAGE_OPTIONS
			),
			fort:       load_images_from_directory(File.join DIR[:images], 'Fort'),
			enemies: {
				normal:   load_images_from_directory(File.join DIR[:images], 'Enemies/Normal'),
				big:      load_images_from_directory(File.join DIR[:images], 'Enemies/Big'),
				wizard:   load_images_from_directory(File.join DIR[:images], 'Enemies/Wizard'),
				zombie:   load_images_from_directory(File.join DIR[:images], 'Enemies/Zombie')
			},
			enemies_left: {
				normal:   load_images_from_directory(File.join DIR[:images], 'Enemies/Left/Normal'),
				big:      load_images_from_directory(File.join DIR[:images], 'Enemies/Left/Big'),
				wizard:   load_images_from_directory(File.join DIR[:images], 'Enemies/Left/Wizard'),
				zombie:   load_images_from_directory(File.join DIR[:images], 'Enemies/Left/Zombie')
			}
		},
		audio: {
			beats: load_audio_from_directory(DIR[:beats])
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
					name: File.join(DIR[:fonts], 'Bombardier.ttf')
				),
				scores:   Gosu::Font.new(
					SETTINGS.game(:fonts)[:game_over_scores][:size],
					name: File.join(DIR[:fonts], 'Ubuntu.ttf')
				)
			}
		}
	}
end
