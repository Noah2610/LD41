module Melodies
	class Second < Melody
		def set_beats
			beats   = []
			3.times do
				beats << :Second_G << :Second_A << :Second_A_Hash
			end
			beats   << :Second_D << :Second_C << :Second_A_Hash << :Second_A << :Second_G << :Second_D << :Second_F
			@beats  = beats
		end
	end
end
