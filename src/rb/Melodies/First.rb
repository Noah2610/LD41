module Melodies
	class First < Melody
		def set_beats
			beats   = []
			beats   << :First_G      << :First_F_Hash << :First_F << :First_E
			3.times do
				beats << :First_D_Hash << :First_A_Hash << :First_A << :First_D
			end
			@beats  = beats
		end
	end
end
