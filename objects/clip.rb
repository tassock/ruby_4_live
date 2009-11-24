class Clip < LiveObject
  
  attr_accessor :clip_slot_id
  
  def initialize(id, clip_slot_id)
    self.id = id
    self.clip_slot_id = clip_slot_id
  end
  
end