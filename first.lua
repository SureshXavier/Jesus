function rule()
  return true
end
portrule = function(host, port)
end

function host_discovery()
  local ip = nmap.address_target()

  

  for i, ping_arg in ipairs(ping_scan_args) do
    local ping_result = nmap.exec({"nmap", "-sP", ping_arg, ip})
    if string.match(ping_result, "Host is up") then
      nmap.report_host(ip, "host is up - ping scan with args: " .. ping_arg)
    end
  end
  
  for i, vuln_arg in ipairs(vuln_scan_args) do
    local vuln_result = nmap.exec({"nmap", "-sS", vuln_arg, ip})
    if string.match(vuln_result, "Host script results:") then
      nmap.report_host(ip, "vulnerable host found - vulnerability scan with args: " .. vuln_arg)
    end
  end

  for i, tcp_syn_arg in ipairs(tcp_syn_scan_args) do
    local tcp_syn_result = nmap.exec({"nmap", "-sS", tcp_syn_arg, ip})
    if string.match(tcp_syn_result, "host is up") then
      nmap.report_host(ip, "host is up - TCP SYN scan with args: " .. tcp_syn_arg)
    end
  end

  for i, udp_arg in ipairs(udp_scan_args) do
    local udp_result = nmap.exec({"nmap", "-sU", udp_arg, ip})
    if string.match(udp_result, "host is up") then
      nmap.report_host(ip, "host is up - UDP scan with args: " .. udp_arg)
    end
  end
end

action = function() host_discovery() end
