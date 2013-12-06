AgentFIX.session_defaults.merge!(
    BeginString: "FIX.4.2",
    SocketConnectHost: "localhost",
    DataDictionary: "etc/FIX42.xml"
)

AgentFIX.define_acceptor :fixHost do |a|
	a.default = { SenderCompID: "ACCEPTOR", SocketAcceptPort: 5002, FileLogPath: "hostLog", FileStorePath: "hostStore" }
	a.session = { TargetCompID: "INITIATOR" }
end

AgentFIX.define_initiator :fixClient do |a|
	a.default = { SenderCompID: "INITIATOR", SocketConnectPort: 5002, SocketConnectHost: "localhost", FileLogPath: "clientLog", FileStorePath: "clientStore" }
	a.session = { TargetCompID: "ACCEPTOR" }
end
