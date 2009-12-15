class LiveSet
  
  attr_accessor :connection, :objects
  
  # Scan Live set for tracks, devices, clip slots and clips
  def initialize(c)
    self.connection = c
    self.objects = []
    get_master_track
    get_tracks
    devices.map {|d| d.get_parameters }
    clip_slots.map {|c| c.get_clip }
    puts "Scan Complete"
  end
  
  def refresh_objects
    objects.map {|o| o.live_set = self}
  end
  
  def inspect
    "LiveSet: #{tracks.length} tracks, #{devices.length} devices, #{device_parameters.length} parameters, #{clip_slots.length} clip slots, #{clips.length} clips"
  end
  
  def find(id)
    objects.select{|t| t.id == id}[0]
  end
  
  def tracks
    objects.select { |o| o.kind_of? Track }
  end
  
  def devices
    objects.select { |o| o.kind_of? Device }
  end
  
  def device_parameters
    objects.select { |o| o.kind_of? DeviceParameter }
  end
  
  def clip_slots
    objects.select { |o| o.kind_of? ClipSlot }
  end
  
  def clips
    objects.select { |o| o.kind_of? Clip }
  end
  
  def add_object(obj)
    if objects.select { |o| o.id == obj.id }.empty?
      objects << obj
    else
      objects.reject! { |o| o.kind_of? Device and o.track_id == obj.id }
      puts "Warning: Attempted to add an object with a duplicate ID #{obj.inspect}"
    end
  end
  
  def get_tracks
    track_count.times do |i|
      track_id = connection.live_path("goto live_set tracks #{i}")[0][1][1]
      add_object(Track.new(:id => track_id, :order => i, :live_set => self))
    end
  end
  
  def get_master_track
    track_id = connection.live_path("goto live_set master_track")[0][1][1]
    add_object(Track.new(:id => track_id, :is_master => true, :live_set => self))
  end
  
  def track_count
    connection.live_path("goto live_set")
    connection.live_path("getcount tracks")[0][1][2]
  end
  
end