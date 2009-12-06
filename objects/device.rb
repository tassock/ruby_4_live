class Device < LiveObject
  
  attr_accessor :track_id, :order
  
  OBJECT_ATTRIBUTES['device']['properties'].each do |method|
    attr_accessor method
  end
  
  OBJECT_ATTRIBUTES['device']['functions'].each do |method|
    define_method method do
      set_path
      @@connection.live_call(method)
    end
  end
  
  def self.all
    @@objects.select { |o| o.kind_of? Device }
  end
  
  def track
    Track.find(track_id)
  end
  
  def parameters
    @@objects.select { |o| o.kind_of? DeviceParameter and o.device_id == id}
  end
  
  def parameter_count
    @@connection.live_path("goto live_set #{track.path} devices #{order}")
    @@connection.live_path("getcount parameters")[0][1][2]
  end
  
  def get_parameters
    parameter_count.times do |i|
      parameter_id = @@connection.live_path("goto live_set #{track.path} devices #{order} parameters #{i}")[0][1][1]
      LiveSet.add_object(DeviceParameter.new(:id => parameter_id, :device_id => id, :order => i))
    end
  end
  
end