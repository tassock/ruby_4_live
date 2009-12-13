# This class represents a (automapable) parameter within a MIDI or Audio DSP-Device
class DeviceParameter < LiveObject
  
  attr_accessor :device_id, :order
  
  OBJECT_ATTRIBUTES['deviceparameter']['properties'].each do |method|
    attr_accessor method
  end
  
  def device
    Device.find(device_id)
  end
  
end