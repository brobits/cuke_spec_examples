$LOAD_PATH << "#{File.dirname(__FILE__)}/../lib"

AgentZMQ.define_ZMQ_PUB :zmqPublisher do |a|
	a.end_point_type = :bind
	a.end_points = ['tcp://localhost:6002']
	a.socket_opts << {ZMQ::LINGER=>3000}
end

AgentZMQ.define_ZMQ_SUB :zmqSubscriber do |a|
	a.end_point_type = :connect
	a.end_points = ['tcp://localhost:6002']
	a.socket_opts << {ZMQ::SUBSCRIBE=>''}
end
