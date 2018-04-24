#!/bin/bash

files=('./README.md' './MedievalMelodyMayhem.rb' './settings.yml' './Gemfile' './.gitignore' './vimrc' './bin/vimall.sh' './bin/build.sh' './bin/log.sh')
IFS=$'\n'
files_find=($( find ./src/rb -type f -iname '*.rb' ))
vim '+source ./vimrc' '+b MedievalMelodyMayhem.rb | vsp | vertical resize 160 | b src/rb/Game.rb | tabnew % | b src/rb/Fort.rb' ${files[@]} ${files_find[@]}
