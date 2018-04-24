module Melodies
	class Second < Melody
		def set_beats
			beats   = []
			beats   << :Synth_G      << :Synth_F_Hash << :Synth_F << :Synth_E
			3.times do
				beats << :Synth_D_Hash << :Synth_A_Hash << :Synth_A << :Synth_D
			end
			@beats  = beats
		end
	end
end
