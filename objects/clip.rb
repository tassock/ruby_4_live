class Clip < LiveObject
  
  attr_accessor :clip_slot_id
  
  OBJECT_ATTRIBUTES['clip']['properties'].each do |method|
    attr_accessor method
  end
  
  OBJECT_ATTRIBUTES['clip']['functions'].each do |method|
    define_method method do
      set_path
      @@connection.live_call(method)
    end
  end
  
  def self.all
    @@objects.select { |o| o.kind_of? Clip }
  end
  
end