class ClipSlot < LiveObject
  
  attr_accessor :track_id, :order
  
  OBJECT_ATTRIBUTES['clip_slot']['properties'].each do |method|
    attr_accessor method
  end
  
  OBJECT_ATTRIBUTES['clip_slot']['functions'].each do |method|
    define_method method do
      set_path
      @@connection.live_call(method)
    end
  end
  
  def self.all
    @@objects.select { |o| o.kind_of? ClipSlot }
  end
  
  def track
    Track.find(track_id)
  end
  
  # ToDo: This is not prepared to handle nil
  def clip
    existing = @@objects.select { |o| o.kind_of? Clip and o.clip_slot_id == id}
    if existing.empty? 
      clip_id = @@connection.live_path("goto live_set tracks #{track.order} clip_slots #{order} clip")[0][1][1]
      LiveSet.add_object(Clip.new({:id => clip_id, :clip_slot_id => id}))
      clip
    else
      existing[0]
    end
  end
  
end