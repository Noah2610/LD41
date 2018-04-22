#!/bin/bash
## Build windows executable file (*.exe), using the Gem 'Ocra'

entry_file='./LD41.rb'
gemfile='./Gemfile'
output_file='./LD41.exe'
IFS=$'\n'
other_files=($( find ./src -type f ))

ocra $entry_file ${other_files[@]} --windows --gemfile $gemfile --output $output_file
