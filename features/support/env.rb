require 'rubygems'
require 'bundler/setup'
require 'cuke_mem'
require 'agent_zmq/cucumber'
require 'agent_fix/cucumber'
require 'fix_spec/cucumber'
require 'fix_spec/builder'
require 'protobuf_spec/cucumber'
require 'protobuf_spec/builder'

FIXSpec::data_dictionary= FIXSpec::DataDictionary.new "features/support/FIX42.xml"

# ignore the comparison of dynamic fields within json fix messages
JsonSpec.configure do
  exclude_keys "BodyLength", "CheckSum", "MsgSeqNum"
end

AgentZMQ.start
AgentFIX.start

at_exit do
	AgentFIX.stop
	AgentZMQ.stop
end
