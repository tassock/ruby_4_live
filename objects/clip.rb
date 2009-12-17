class Clip < LiveObject
  
  attr_accessor :clip_slot_id
  
  OBJECT_ATTRIBUTES['clip']['properties'].each do |method|
    attr_accessor method
  end
  
  OBJECT_ATTRIBUTES['clip']['functions'].each do |method|
    define_method method do
      set_path
      sleep SLEEP_INTERVAL
      connection.live_call(method)
    end
  end
  
  def clip_slot
    live_set.find(clip_slot_id)
  end
  
end