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
  end
  
  def live_path(arg)
    m = OSC::Message.new('/live_path', 's', "#{arg}")
    @connection.send m, 0, @host, @send_port
    
    response = []
    @server.add_method '/slot1', 'si' do |msg|
      response << [msg.address, msg.args]
      # puts response.inspect
    end
    # @server.add_method '/slot2', 'si' do |msg|
    #   response << [msg.address, msg.args]
    # end
    @server.add_method '/slot3', 'ssi' do |msg|
      response << [msg.address, msg.args]
    end
    Thread.new do
      @server.serve
    end
    while response.empty?
      sleep 0.001
    end
    # puts response.inspect
    response
  end
  
  def set_live_object(arg)
    m = OSC::Message.new('/set_live_object', 's', "#{arg}")
    @connection.send m, 0, @host, @send_port
  end
  
  def live_object(arg)
    m = OSC::Message.new('/live_object', 's', "#{arg}")
    @connection.send m, 0, @host, @send_port
    
    response = []
    @server.add_method '/slot1', 'ss' do |msg|
      response << [msg.address, msg.args]
    end
    @server.add_method '/slot1', 's*' do |msg|
      response << [msg.address, msg.args]
    end
    Thread.new do
      @server.serve
    end
    while response.empty?
      sleep 0.001
    end
    # puts response.inspect
    response
  end
  
  def live_call(arg)
    m = OSC::Message.new('/live_object', 's', "call #{arg}")
    @connection.send m, 0, @host, @send_port
  end
  
  def live_transport
    @server.add_method '/transport', 'iiii' do |msg|
      LiveScheduler.beat_value(msg.args[3], msg.args[2], msg.args[1], msg.args[0])
      # puts "#{msg.args[0]}, #{msg.args[1]}, #{msg.args[2]}, #{msg.args[3]}"
    end
    Thread.new do
      @server.serve
    end
  end

end