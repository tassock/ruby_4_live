# http://www.wonderolie.nl/2009/opensoundcontrol-list-from-processing-to-maxmsp/
require 'osc' # http://github.com/halfbyte/rosc

class LiveConnection
  
  def initialize(host, send_port, recieve_port)
    @host = host
    @send_port = send_port
    @recieve_port = recieve_port
    @connection = OSC::UDPSocket.new
    @server = OSC::UDPServer.new
    @server.bind @host, @recieve_port
    @response = []
    @server.add_method '/slot1', 'si' do |msg|
      @response << [msg.address, msg.args]
    end
    @server.add_method '/slot1', 'ss' do |msg|
      @response << [msg.address, msg.args]
    end
    @server.add_method '/slot1', 's*' do |msg|
      @response << [msg.address, msg.args]
    end
    @server.add_method '/slot3', 'ssi' do |msg|
      @response << [msg.address, msg.args]
    end
    serve
  end
  
  def serve
    Thread.new do
      @server.serve
    end
  end
  
  def live_path(arg)
    send_message('/live_path', arg, true)
  end
  
  def set_live_object_path(arg)
    send_message('/set_live_object', arg, false)
  end
  
  def live_object(arg)
    send_message('/live_object', arg, true)
  end
  
  def send_message(address, arg, callback=false)
    m = OSC::Message.new(address, 's', "#{arg}")
    @connection.send m, 0, @host, @send_port
    get_callback if callback
  end
  
  def live_call(arg)
    m = OSC::Message.new('/live_object', 's', "call #{arg}")
    @connection.send m, 0, @host, @send_port
  end
  
  def get_callback
    while @response.empty?
      sleep 0.01
    end
    return_val = [] + @response
    @response.clear
    return_val
  end

end