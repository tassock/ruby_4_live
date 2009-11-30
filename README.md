# Ruby 4 Live #

A Ruby implementation of the [Ableton Live](http://ableton.com/) API. The current version connects to an included [Max For Live](http://ableton.com/maxforlive) patch via OSC to interact with the API. 

  
## Author ##

Peter Marks (petertmarks [at] gmail [dot] com)


## Status ##

This is a young project (first commit 11/24/2009) and the API is subject to change. Only Track, Clip and ClipSlot Live objects have been implemented


## Dependancies ##

+ [OpenSound Control for Ruby](http://github.com/fugalh/rosc)


## Usage ##

	require 'live_api'
	@set = LiveSet.new
	@set.get_tracks
	Track.find(3).get_clip_slots
	Track.find(3).clip_slots[0].clip.get('name')
	
	
## My To-Do List ##

+ Implement functionality for Device and other objects.
+ Test suite
+ Make gem version