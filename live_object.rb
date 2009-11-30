class LiveObject
  
  attr_accessor :id
  
  def initialize(options)
    options.each do |name, value|
      self.send(name.to_s + '=', value)
    end
  end
  
  def self.find(id)
    @@objects.select{|t| t.id == id}[0]
  end
  
  def set_path
    @@connection.set_live_object("id #{id}")
  end
  
  def get(property)
    set_path
    @@connection.live_object("get #{property}")[0][1][1]
  end
  
  def set(property, value)
    set_path
    @@connection.live_object("set #{property} #{value}")
  end
  
end