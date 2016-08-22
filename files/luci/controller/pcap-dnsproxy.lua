-- Copyright 2016
-- Jason Lin
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.pcap-dnsproxy", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/pcap-dnsproxy") then
		return
	end

	entry({"admin", "services", "pcap-dnsproxy"}, cbi("pcap-dnsproxy"), _("Pcap-DNSProxy"), 70).dependent = true
end