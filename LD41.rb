#!/bin/env ruby

require 'gosu'
require 'logger'
require 'yaml'

#TODO: Remove development gems for final version
require 'awesome_print'
require 'byebug'
#require 'simple-benchmark'

ROOT = File.expand_path(File.dirname(__FILE__))

DIR = {
	src:      File.join(ROOT, 'src'),
	rb:       File.join(ROOT, 'src/rb'),
	misc:     File.join(ROOT, 'src/rb/misc'),
	includes: File.join(ROOT, 'src/rb/Includes'),
	enemies:  File.join(ROOT, 'src/rb/Enemies'),
	clusters: File.join(ROOT, 'src/rb/Clusters'),
	images:   File.join(ROOT, 'src/Art/Images'),
	audio:    File.join(ROOT, 'src/Art/Audio'),
	settings: File.join(ROOT, 'settings.yml'),
	log:      File.join(ROOT, 'log')
}

Dir.mkdir DIR[:log]  unless (File.directory? DIR[:log])
LOGFILE = File.join DIR[:log], 'development.log'

require File.join DIR[:misc],  'require_files'
require File.join DIR[:rb],    'Game'
