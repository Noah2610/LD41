#!/bin/bash

files=('./README.md' './LD41.rb' './settings.yml' './Gemfile' './.gitignore' './vimrc' './bin/vimall.sh' './bin/build.sh' './bin/log.sh')
IFS=$'\n'
files_find=($( find ./src/rb -type f -iname '*.rb' ))
vim '+source ./vimrc' ${files[@]} ${files_find[@]}
