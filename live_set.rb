class LiveSet
  
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
      LiveSet.add_object(Track.new(track_id, i))
    end
  end
  
  def track_count
    @@connection.live_path("goto live_set")
    @@connection.live_path("getcount tracks")[0][1][2]
  end
  
end