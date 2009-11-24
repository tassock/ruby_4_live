class Track < LiveObject
  
  attr_accessor :order
  
  def initialize(id, order)
    self.id = id
    self.order = order
  end
  
  def self.all
    @@objects.select { |o| o.kind_of? Track }
  end
  
  def clip_slots
    @@objects.select { |o| o.kind_of? ClipSlot and o.track_id == id}
  end
  
  def clip_slot_count
    set_path
    # @@connection.live_path("goto live_set")
    @@connection.live_object("get clip_slots")[0][1][2]
  end
  
  def get_clip_slots
    5.times do |i|
      clip_slot_id = @@connection.live_path("goto live_set tracks #{id} clip_slots #{i}")[0][1][1]
      LiveSet.add_object(ClipSlot.new(clip_slot_id, i, id))
    end
  end
  
end