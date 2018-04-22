def get_resources
	return {
		images: {
			fort:   Gosu::Image.new(
				File.join(DIR[:images], 'Fort.png'),
				retro: true
			),
			enemies: {
				normal: load_images_from_directory(File.join DIR[:images], 'Enemies/Normal')
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
			)
		}
	}
end
