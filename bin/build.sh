#!/bin/bash
## Build windows executable file (*.exe), using the Gem 'Ocra'

entry_file='./MedievalMelodyMayhem.rb'
gemfile='./Gemfile'
output_file='./MedievalMelodyMayhem.exe'
IFS=$'\n'
other_files=('./settings.yml')
other_files_find=($(    \
	find ./src -type f -o \
		-iname '*.rb'    -o \
		-iname '*.png'   -o \
		-iname '*.jpg'   -o \
		-iname '*.jpeg'  -o \
		-iname '*.wav'   -o \
		-iname '*.ttf'   -o \
		-iname '*.yml'      \
))

ocra $entry_file ${other_files[@]} ${other_files_find[@]} --windows --gemfile $gemfile --output $output_file
