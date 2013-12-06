require 'rubygems'
require 'bundler/steup'
require 'cuke_mem'
require 'agent_fix/cucumber'
require 'fix_spec/cucumber'
require 'fix_spec/builder'
require 'protobuf_spec/cucumber'
require 'protobuf_spec/builder'

FIXSpec::data_dictionary= FIXSpec::DataDictionary.new "features/support/FIX42.xml"

AgentZMQ.start
AgentFIX.start

at_exit do
	AgentFIX.stop
	AgentZMQ.stop
end
