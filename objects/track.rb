class Track < LiveObject
  
  attr_accessor :order, :is_master
  
  OBJECT_ATTRIBUTES['track']['properties'].each do |method|
    attr_accessor method
  end
  
  OBJECT_ATTRIBUTES['track']['functions'].each do |method|
    define_method method do
      set_path
      connection.live_call(method)
    end
  end
  
  def after_initialize
    get_clip_slots unless is_master
    get_devices
    get_mixer_device
  end
  
  def mixer_device
    live_set.objects.select { |o| o.kind_of? Device and o.track_id == id and o.is_mixer == true}[0]
  end
  
  def path
    is_master ? "master_track" : "tracks #{order}"
  end
  
  def clip_slots
    live_set.objects.select { |o| o.kind_of? ClipSlot and o.track_id == id}#.sort_by {|c| c['order'] }
  end
  
  def devices
    live_set.objects.select { |o| o.kind_of? Device and o.track_id == id}
  end
  
  def mixer_device
    live_set.objects.select { |o| o.kind_of? MixerDevice and o.track_id == id}[0]
  end
  
  def clip_slot_count
    set_path
    connection.live_object("getcount clip_slots")[0][1][2]
  end
  
  private
  
  def get_clip_slots
    10.times do |i|
      clip_slot_id = connection.live_path("goto live_set #{path} clip_slots #{i}")[0][1][1]
      clip_slot = ClipSlot.new(:id => clip_slot_id, :order => i, :track_id => id, :live_set => live_set)
      live_set.add_object(clip_slot)
    end
  end
  
  def get_devices
    10.times do |i|
      device_id = connection.live_path("goto live_set #{path} devices #{i}")[0][1][1]
      break if device_id == 0
      device = Device.new(:id => device_id, :order => i, :track_id => id, :live_set => live_set)
      live_set.add_object(device)
    end
  end
  
  def get_mixer_device
    device_id = connection.live_path("goto live_set #{path} mixer_device")[0][1][1]
    device = MixerDevice.new(:id => device_id, :track_id => id, :live_set => live_set)
    live_set.add_object(device)
  end
  
end