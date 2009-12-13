# This class represents a Mixer Device in Live which give you access to the volume and panning properties of a track
class MixerDevice < Device
  
  def get_parameters
    ['crossfader', 'cue_volume', 'panning', 'volume'].each do |param|
      parameter_id = connection.live_path("goto live_set #{track.path} mixer_device #{param}")[0][1][1]
      unless parameter_id.nil? or parameter_id == 0
        live_set.add_object(DeviceParameter.new(:id => parameter_id, :device_id => id, :live_set => live_set))
      end
    end
  end
  
end