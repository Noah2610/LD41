SETTINGS   = Settings.new
RESOURCES  = get_resources
DIFFICULTY = DifficultyManager.new
SCORE      = Score.new
AUDIO      = AudioManager.new
MELODIES   = Melodies.get_melodies

GAME       = Game.new
GAME.init_game
SCORE.init
LOGGER.info 'Game started'
GAME.show

LOGGER.info 'Exitted naturally'
