# This class represents a Mixer Device in Live which give you access to the volume and panning properties of a track
class MixerDevice < Device
  
  def get_parameters
    ['crossfader', 'cue_volume', 'panning', 'volume'].each do |param|
      parameter_id = @@connection.live_path("goto live_set #{track.path} mixer_device #{param}")[0][1][1]
      unless parameter_id.nil? or parameter_id == 0
        LiveSet.add_object(DeviceParameter.new(:id => parameter_id, :device_id => id))
      end
    end
  end
  
  # def self.all
  #   @@objects.select { |o| o.kind_of? MixerDevice }
  # end
  # 
  # def track
  #   Track.find(track_id)
  # end
  # 
  # def parameters
  #   @@objects.select { |o| o.kind_of? DeviceParameter and o.device_id == id}
  # end
  # # 
  # # def parameter_count
  # #   @@connection.live_path("goto live_set #{track.path}") # wont work for master track
  # #   @@connection.live_path("getcount parameters")[0][1][2]
  # # end
  # # 
  # # def get_parameters
  # #   parameter_count.times do |i|
  # #     parameter_id = @@connection.live_path("goto live_set #{track.path} devices #{order} parameters #{i}")[0][1][1]
  # #     LiveSet.add_object(DeviceParameter.new({:id => parameter_id, :device_id => id, :order => i}))
  # #   end
  # # end
  
end