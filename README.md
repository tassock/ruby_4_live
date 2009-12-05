# Ruby 4 Live #

A Ruby implementation of the [Ableton Live](http://ableton.com/) API. The current version connects to an included [Max For Live](http://ableton.com/maxforlive) patch via OSC to interact with the API. 

  
## Author ##

Peter Marks (petertmarks [at] gmail [dot] com)


## Status ##

This is a young project (first commit 11/24/2009) and the API is subject to change. 


## Dependancies ##

+ [OpenSound Control for Ruby](http://github.com/fugalh/rosc)


## Usage ##

Creating a new LiveSet scans the live set for the ID's of every Track, Device, DeviceParameter, ClipSlot and Clip 'LiveObject':

	>  require 'live_api'
	=> true
	>  LiveSet.new 
	   Scanned Live set: 2 tracks, 2 devices, 40 clip slots, 11 clips
	=> #<LiveSet>

It also fetches a default attributes for those objects as specified in config/settings.yaml. It may take a few seconds to load everything. If you're having trouble, try increasing the SLEEP_INTERVAL constant. 

The 'all' method returns an array of objects of that type:

	>  Track.all
	=> [#<Track @order=0, @id=2, @name="1-Audio">, #<Track @order=1, @id=3, @name="2-Audio">]

LiveObject properties are as accessor methods: 

	>  Track.all[0].name
	=> "1-Audio"
	
	
## My To-Do List ##

+ Implement functionality for LiveSet, Scene and other objects.
+ Transport listeners
+ Test suite
+ Make gem version