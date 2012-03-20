#!/opt/local/bin/ruby

file = File.new("dhcpd.conf", "r")

new_record=nil
end_record=nil
hostname = mac_addr = ip_addr = dns_srvs = ''

while (line = file.gets)
  if line =~ /^host (.*) {/
    hostname = $1
    new_record = true
  end
  if line =~ /hardware ethernet\s*(.*);/
    mac_addr = $1
  end
  if line =~ /fixed-address\s*(.*);/
    ip_addr = $1
  end
  if line =~ /option domain-name-servers\s*(.*);/
    dns_srvs = $1
  end
  if line =~ /^\}$/
    unless new_record.nil?
      end_record = true
    end
  end

  unless end_record.nil?
    puts "#{hostname},#{ip_addr},#{mac_addr},#{dns_srvs}"
    hostname = mac_addr = ip_addr = dns_srvs = ''
    new_record = end_record = nil
  end
end
