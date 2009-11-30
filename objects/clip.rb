class Clip < LiveObject
  
  attr_accessor :clip_slot_id
  
  PROPERTY_NAMES = [:name, :color, :length]
  FUNCTION_NAMES  = [:fire, :stop]
  
  PROPERTY_NAMES.each do |method|
    define_method method do
      get(method)
    end
  end

  FUNCTION_NAMES.each do |method|
    define_method method do
      set_path
      @@connection.live_call(method)
    end
  end
  
end