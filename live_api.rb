require 'live_set'
require 'live_connection'
require 'live_object'
require 'objects/track'
require 'objects/clip_slot'
require 'objects/clip'

@@connection = LiveConnection.new('localhost', 7402, 7403)
@@objects = []