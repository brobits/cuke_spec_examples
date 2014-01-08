require 'rubygems'
require 'bundler/setup'
require 'cuke_mem'
require 'agent_zmq/cucumber'
require 'agent_fix/cucumber'
require 'fix_spec/cucumber'
require 'fix_spec/builder'
require 'protobuf_spec/cucumber'
require 'protobuf_spec/builder'

module FIXMessageCache
    def last_fix
        @last_fix
    end
end

Around('@with_data_dictionary') do |scenario, block|
  FIXSpec::data_dictionary= FIXSpec::DataDictionary.new "features/support/FIX42.xml"
  block.call
  FIXSpec::data_dictionary= nil
end

Around('@ignore_length_and_checksum') do |scenario, block|
  JsonSpec.excluded_keys=%w(CheckSum BodyLength)
  block.call
  JsonSpec.excluded_keys=JsonSpec::Configuration::DEFAULT_EXCLUDED_KEYS
end

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
