class ClipSlot < LiveObject
  
  attr_accessor :track_id, :order
  
  OBJECT_ATTRIBUTES['clipslot']['properties'].each do |method|
    attr_accessor method
  end
  
  OBJECT_ATTRIBUTES['clipslot']['functions'].each do |method|
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
  
  def clip
    @@objects.select { |o| o.kind_of? Clip and o.clip_slot_id == id}[0]
  end
  
  def get_clip
    if has_clip == 1
      clip_id = @@connection.live_path("goto live_set #{track.path} clip_slots #{order} clip")[0][1][1]
      LiveSet.add_object(Clip.new(:id => clip_id, :clip_slot_id => id))
    end
  end
  
end