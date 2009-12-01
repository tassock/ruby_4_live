require 'rubygems'
SETTINGS          = YAML::load(File.read('config/settings.yaml'))
OBJECT_ATTRIBUTES = YAML::load(File.read('config/object_attributes.yaml'))
SLEEP_INTERVAL    = 0.05

require 'live_set'
require 'live_connection'
require 'live_object'
require 'objects/track'
require 'objects/device'
require 'objects/clip_slot'
require 'objects/clip'

@@connection = LiveConnection.new('localhost', 7402, 7403)
@@objects = []
@@clip_plays = []