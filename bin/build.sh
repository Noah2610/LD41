#!/bin/bash
## Build windows executable file (*.exe), using the Gem 'Ocra'

entry_file='./LD41.rb'
gemfile='./Gemfile'
output_file='./LD41.exe'
IFS=$'\n'
other_files=('./settings.yml')
other_files_find=($( find ./src -type f ))

ocra $entry_file ${other_files[@]} ${other_files_find[@]} --windows --gemfile $gemfile --output $output_file
