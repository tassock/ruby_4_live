# Ruby 4 Live #

A Ruby implementation of the Ableton Live API (www.ableton.com). The current implementation connects to an included Max 4 Live patch via OSC to interact with the API. 

  
## Author ##

Peter Marks (petertmarks [at] gmail [dot] com)


## Status ##

This is a young project (first commit 11/24/2009) and the API is subject to change. 


## Usage ##

require 'live_api'
@set = LiveSet.new
@set.get_tracks
Track.find(3).get_clip_slots
Track.find(3).clip_slots[0].clip.get('name')