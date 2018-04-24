#!/bin/env ruby

require 'gosu'
require 'logger'
require 'yaml'

ROOT = File.expand_path(File.dirname(__FILE__))

DIR = {
	src:      File.join(ROOT, 'src'),
	rb:       File.join(ROOT, 'src/rb'),
	misc:     File.join(ROOT, 'src/rb/misc'),
	includes: File.join(ROOT, 'src/rb/Includes'),
	enemies:  File.join(ROOT, 'src/rb/Enemies'),
	clusters: File.join(ROOT, 'src/rb/Clusters'),
	melodies: File.join(ROOT, 'src/rb/Melodies'),
	images:   File.join(ROOT, 'src/Art/Images'),
	audio:    File.join(ROOT, 'src/Art/Audio'),
	beats:    File.join(ROOT, 'src/Art/Audio/Beats'),
	fonts:    File.join(ROOT, 'src/Fonts'),
	settings: File.join(ROOT, 'settings.yml'),
	log:      File.join(ROOT, 'log')
}

Dir.mkdir DIR[:log]  unless (File.directory? DIR[:log])
LOGFILE = File.join DIR[:log], 'development.log'

require File.join DIR[:misc],  'require_files'
require File.join DIR[:rb],    'Game'
require File.join DIR[:rb],    'init'
