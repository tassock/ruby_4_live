class LiveSet
  
  # Scan Live set for tracks, devices, clip slots and clips
  def initialize
    get_tracks
    tracks.each do |t|
      t.get_clip_slots
      t.get_devices
    end
    puts "Scanned Live set: #{Track.all.length} tracks, #{Device.all.length} devices, #{ClipSlot.all.length} clip slots, #{Clip.all.length} clips"
  end
  
  def tracks
    @@objects.select { |o| o.kind_of? Track }
  end
  
  def self.add_object(obj)
    if @@objects.select { |o| o.id == obj.id }.empty?
      @@objects << obj
    end
  end
  
  def get_tracks
    track_count.times do |i|
      track_id = @@connection.live_path("goto live_set tracks #{i}")[0][1][1]
      LiveSet.add_object(Track.new({:id => track_id, :order => i}))
    end
  end
  
  def track_count
    @@connection.live_path("goto live_set")
    @@connection.live_path("getcount tracks")[0][1][2]
  end
  
end