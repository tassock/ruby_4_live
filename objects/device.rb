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
  
end