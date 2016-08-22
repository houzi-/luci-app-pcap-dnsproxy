-- Copyright 2016
-- Jason Lin
-- Licensed to the public under the Apache License 2.0.

local NXFS = require "nixio.fs"
local SYS  = require "luci.sys"

if luci.sys.call("pidof Pcap_DNSProxy >/dev/null") == 0 then
	m = Map("pcap-dnsproxy", translate("Pcap-DNSProxy"), translate("Pcap-DNSProxy is running"))
else
	m = Map("pcap-dnsproxy", translate("Pcap-DNSProxy"), translate("Pcap-DNSProxy is not running"))
end

s = m:section(TypedSection, "pcap-dnsproxy", translate("Configure"))
s.anonymous = true

o = s:option(Flag, "enable", translate("Enable"))
o.rmempty = false

o = s:option(Button, "process")
o.title = translate("Guardian of the process")
o.inputtitle = translate("Enable")
o.description = translate("Only once")

o.inputstyle = "apply"
o.write = function()
	SYS.call("/etc/init.d/check")
end

local file = "/etc/pcap-dnsproxy/Config.conf"
o = s:option(TextValue, "")
o.description = translate("Modify the configuration file,and then save the application")
o.rows = 20
o.wrap = "off"
o.cfgvalue = function(left, section)
	return NXFS.readfile(file) or ""
end
o.write = function(left, section, value)
	NXFS.writefile(file, value:gsub("\r\n", "\n"))
end

local apply = luci.http.formvalue("cbi.apply")
if apply then
	io.popen("/etc/init.d/pcap-dnsproxy restart")
end

return m