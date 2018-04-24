module Melodies
	class Third < Melody
		def set_beats
			beats = []
			beats << :Third_C << :Third_C << :Third_A_Hash << :Third_A_Hash << :Third_Unknown << :Third_G << :Third_F_Hash << :Third_F << :Third_D_Hash << :Third_C << :Third_A_Hash
			beats << :Third_C << :Third_D_Hash << :Third_F << :Third_A_Hash << :Third_C
			@beats  = beats
		end
	end
end
