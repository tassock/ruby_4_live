class LiveObject
  
  attr_accessor :id
  
  def initialize(options)
    options.each do |name, value|
      puts "ID CANNOT BE NIL OR ZERO #{self.inspect}" if (name.to_s == 'id' and (value == 0 or value.nil?))
      self.send(name.to_s + '=', value)
    end
    default_properties.map {|p| self.get(p) } unless default_properties.nil?
    after_initialize
  end
  
  def after_initialize
  end
  
  # get default properties from config/settings.rb
  def default_properties
    begin
      SETTINGS[self.class.to_s.downcase]['default_properties']
    rescue
      []
    end
  end
  
  def self.find(id)
    @@objects.select{|t| t.id == id}[0]
  end
  
  def set_path
    @@connection.set_live_object_path("id #{id}")
  end
  
  def get(property)
    set_path
    sleep SLEEP_INTERVAL
    self.send(property.to_s + '=', @@connection.live_object("get #{property}")[0][1][1])
  end
  
  def set(property, value)
    set_path
     @@connection.set_live_object("set #{property} #{value}")
  end
  
end