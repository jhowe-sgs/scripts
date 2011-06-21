#!/usr/bin/ruby

# based on http://glarizza.posterous.com/43331766

require 'open-uri'
require 'openssl'
require 'timeout'
require 'rubygems'
require 'yajl'

# sudo /usr/bin/gem install yajl-ruby

# yeah there is some code duplication here. need to meta-abstract it out laterz

#$ system_profiler SPHardwareDataType
#Hardware:
#
#    Hardware Overview:
#
#      Model Name: MacBook Pro
#      Model Identifier: MacBookPro5,2
#      Processor Name: Intel Core 2 Duo
#      Processor Speed: 2.8 GHz
#      Number Of Processors: 1
#      Total Number Of Cores: 2
#      L2 Cache: 6 MB
#      Memory: 8 GB
#      Bus Speed: 1.07 GHz
#      Boot ROM Version: MBP52.
#      SMC Version (system): 1.42f4
#      Serial Number (system): W892
#      Hardware UUID: 62BF
#      Sudden Motion Sensor:
#          State: Enabled

#Diagnostics:
#
#    Power On Self-Test:
#
#      Last Run: 6/1/11 8:20 AM
#      Result: Passed



serial = %x(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}').upcase.chomp

model_id = %x(system_profiler SPHardwareDataType | awk -F': ' '/Model Identifier/ {print $2}').chomp

ram = %x(system_profiler SPHardwareDataType | awk -F': ' '/Memory/ {print $2,$3}').chomp

# system_profiler SPHardwareDataType | awk -F': ' '/Processor Name/ {print $2}'

url = "https://selfsolve.apple.com/warrantyChecker.do?sn=#{serial}&country=USA"

# puts url

parser = Yajl::Parser.new

begin
  res = parser.parse( (open(url).read).chomp.sub(/^null\(/,'').sub(/\)$/,'') )
rescue Timeout::Error
  puts "Timeout::Error: #{$!}"
  exit
rescue OpenURI::HTTPError => the_error
  puts "Something wicked this way went!"
  puts "  URL: #{url}"
  puts "  Had a bad status: #{the_error.message}"
  exit
rescue
  puts "Network connection failed: #{$!}"
  exit
end

puts   "Serial Number:    " + res["SERIAL_ID"]
puts   "Model Type:       " + res["PROD_DESCR"]
puts   "Model ID:         " + model_id
puts   "Installed RAM:    " + ram
puts   "Purchased on:     " + res["PURCHASE_DATE"]

if ( res["HW_HAS_COVERAGE"] == "Y" ) then
  # HW_END_DATE =~ COV_END_DATE
  puts "Coverage Expires: " + res["COV_END_DATE"]
  puts "Repair Days Left: " + res["DAYS_REM_IN_COV"]
else
  puts "System Out of Coverage!" 
  puts "System Age:       " + (res["NUM_DAYS_SINCE_DOP"].to_i/365.0).to_s
end

eth_mac = %x(ifconfig en0 | awk '/ether/ {print $2}').upcase.chomp
eth_ip  = %x(ifconfig en0 | awk '/inet / {print $2}').upcase.chomp
air_mac = %x(ifconfig en1 | awk '/ether/ {print $2}').upcase.chomp
air_ip  = %x(ifconfig en1 | awk '/inet / {print $2}').upcase.chomp

puts   "Airport MAC:      " + air_mac
puts   "Airport IPADDR:   " + air_ip

puts   "Eth MAC:          " + eth_mac
puts   "Eth IPADDR:       " + eth_ip

# require 'uri'
# url = "http://some.tld/?serial=sn&what=what"
# URI.escape(url)
