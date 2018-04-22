def get_resources
	return {
		images: {
			background: Gosu::Image.new(
				File.join(DIR[:images], 'drive/Background.png'),
				GOSU_IMAGE_OPTIONS
			),
			fort:   Gosu::Image.new(
				File.join(DIR[:images], 'Fort.png'),
				GOSU_IMAGE_OPTIONS
			),
			enemies: {
				normal: load_images_from_directory(File.join DIR[:images], 'drive/Normal'),
				big:    load_images_from_directory(File.join DIR[:images], 'drive/Big'),
				wizard: load_images_from_directory(File.join DIR[:images], 'drive/Wizard'),
				zombie: load_images_from_directory(File.join DIR[:images], 'drive/Zombie')
			}
		},
		fonts: {
			debug:  Gosu::Font.new(
				24,
				name: File.join(DIR[:fonts], 'Ubuntu.ttf')
			),
			prompt: Gosu::Font.new(
				SETTINGS.prompt(:font_size),
				name: File.join(DIR[:fonts], 'ProggySquareSZ/ProggySquareSZ.ttf')
			),
			score:  Gosu::Font.new(
				SETTINGS.score(:font_size),
				name: File.join(DIR[:fonts], 'Ubuntu.ttf')
			)
		}
	}
end
