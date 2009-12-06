class LiveSet
  
  # Scan Live set for tracks, devices, clip slots and clips
  def initialize
    get_master_track
    get_tracks
    Device.all.map {|d| d.get_parameters }
    # MixerDevice.all.map {|d| d.get_parameters }
    ClipSlot.all.map {|c| c.get_clip }
    puts "Scanned Live set: #{Track.all.length} tracks, #{Device.all.length} devices, #{DeviceParameter.all.length} parameters, #{ClipSlot.all.length} clip slots, #{Clip.all.length} clips"
  end
  
  def tracks
    @@objects.select { |o| o.kind_of? Track }
  end
  
  def self.add_object(obj)
    # puts "ADDING #{obj.inspect}"
    if @@objects.select { |o| o.id == obj.id }.empty?
      @@objects << obj
    else
      puts "Warning: Attempted to add an object with a duplicate ID #{obj.inspect}"
    end
  end
  
  def get_tracks
    track_count.times do |i|
      track_id = @@connection.live_path("goto live_set tracks #{i}")[0][1][1]
      LiveSet.add_object(Track.new(:id => track_id, :order => i))
    end
  end
  
  def get_master_track
    track_id = @@connection.live_path("goto live_set master_track")[0][1][1]
    LiveSet.add_object(Track.new(:id => track_id, :is_master => true))
  end
  
  def track_count
    @@connection.live_path("goto live_set")
    @@connection.live_path("getcount tracks")[0][1][2]
  end
  
end