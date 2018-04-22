RESOURCES = {
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
			16,
			name: File.join(DIR[:fonts], 'ProggySquareSZ/ProggySquareSZ.ttf')
		)
	}
}
