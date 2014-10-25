#!/usr/bin/ruby

# Utility script to parse local serial number and determine available AppleCare
# While we are at it, do some basic hardware auditing
# Gather it all up and send audit info to a HTTP(s) cache

# Puppet clues: sudo /usr/bin/gem install yajl-ruby colored

# Based on work from http://glarizza.posterous.com/43331766

require 'open-uri'
require 'openssl'
require 'timeout'
# require 'uri'
require 'rubygems'
require 'yajl'
require 'colored'

# Global domination
$air_mac
$eth_mac
$hostname=%x(scutil --get LocalHostName).chomp
$audit_host="http://audit.seattlegirlsschool.org"

# Methudium

def get_serial
  %x(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}').upcase.chomp
end

def gen_url(serial)
  "https://selfsolve.apple.com/warrantyChecker.do?sn=#{serial}&country=USA"
end

def get_info(url)
  parser = Yajl::Parser.new

  begin
    parser.parse( (open(url).read).chomp.sub(/^null\(/,'').sub(/\)$/,'') )
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
end

#$ system_profiler SPDiagnosticsDataType
#      Last Run: 6/1/11 8:20 AM
#      Result: Passed

def hardware_info_short(query)
  %x(system_profiler SPHardwareDataType | awk -F': ' '/#{query}/ {print $2}').chomp.rstrip
end

def hardware_info_long(query)
  %x(system_profiler SPHardwareDataType | awk -F': ' '/#{query}/ {print $2,$3,$4}').chomp.rstrip
end

def battery_info_short(query)
  %x(system_profiler SPPowerDataType | awk -F': ' '/#{query}/ {print $2}').chomp.rstrip
end

def battery_info_long(query)
  %x(system_profiler SPPowerDataType | awk -F': ' '/#{query}/ {print $2,$3,$4}').chomp.rstrip
end

def report(serial, result)

  model_id = hardware_info_short("Model Identifier")
  ram = hardware_info_long("Memory")
  l2_cache = hardware_info_long("L2 Cache")
  proc_name = hardware_info_long("Processor Name")
  proc_speed = hardware_info_long("Processor Speed")
  proc_count = hardware_info_short("Number Of Processors")
  proc_cores = hardware_info_short("Total Number Of Cores")
  bus_speed = hardware_info_long("Bus Speed")
  smc_version = hardware_info_short("SMC Version")
  boot_rom = hardware_info_short("Boot ROM Version")
  hardware_uuid = hardware_info_long("Hardware UUID")

  batt_cycle_count = battery_info_short("Cycle count")
  batt_condition = battery_info_long("Condition")
  batt_charge_remaining = battery_info_short("Charge remaining")
  batt_charge_capacity = battery_info_short("Full charge capacity")

  puts   "Serial Number:    " + result["SERIAL_ID"]
  puts   "Hardware UUID:    " + hardware_uuid
  puts   "Model Type:       " + result["PROD_DESCR"]
  puts   "Model ID:         " + model_id
  puts   "Processor Name:   " + proc_name
  puts   "Processor Speed:  " + proc_speed
  puts   "Processor Count:  " + proc_count
  puts   "Processor Cores:  " + proc_cores
  puts   "Installed RAM:    " + ram
  puts   "L2 Cache:         " + l2_cache

  if batt_cycle_count.to_i >= 300
    puts "Battery Count:    " + batt_cycle_count.red
  elsif batt_cycle_count.to_i >= 250
    puts "Battery Count:    " + batt_cycle_count.yellow
  else
    puts "Battery Count:    " + batt_cycle_count.green
  end

  if batt_condition == "Replace Now"
    puts "Battery Status:   " + batt_condition.red
  elsif batt_condition == "Normal"
    puts "Battery Status:   " + batt_condition.green
  else
    puts "Battery Status:   " + batt_condition.yellow
  end

  puts   "Bus Speed:        " + bus_speed
  puts   "SMC Version:      " + smc_version
  puts   "Boot ROM:         " + boot_rom
  puts   "Purchased on:     " + result["PURCHASE_DATE"]

  if ( result["HW_HAS_COVERAGE"] == "Y" ) then
    # HW_END_DATE =~ COV_END_DATE
    puts "Coverage Expires: " + result["COV_END_DATE"].green
    puts "Repair Days Left: " + result["DAYS_REM_IN_COV"].green
  else
    puts "System Out of Coverage!".red
    puts "System Age (Yrs): " + (result["NUM_DAYS_SINCE_DOP"].to_i/365.0).to_s.red
  end

  network_info

  # url = "http://audit-host/Model-ID/SN/Hardware-UUID/Air-MAC/Eth-MAC/hostname
  begin
    audit_url = prep_url( model_id, result["SERIAL_ID"], hardware_uuid, batt_cycle_count, batt_charge_capacity )
    open( audit_url )
    puts "Sent report to #{audit_url}"
  rescue Timeout::Error
    puts "Timeout::Error: #{$!}"
    exit
  rescue OpenURI::HTTPError => the_error
    puts "Something wicked this way went!"
    puts "  URL: #{audit_url}"
    puts "  Had a bad status: #{the_error.message}"
    exit
  rescue
    puts "Network connection failed: #{$!}"
    exit
  end
end

def prep_url(model_id, serial, uuid, batt_cycles, batt_capacity)
  "#{$audit_host}/#{model_id}/#{serial}/#{uuid}/#{$air_mac}/#{$eth_mac}/#{$hostname}/#{batt_cycles}/#{batt_capacity}"
end

def get_ip4addr(int)
  %x(ifconfig #{int} | awk '/inet / {print $2}').upcase.chomp
end

def get_macaddr(int)
  %x(ifconfig #{int} | awk '/ether/ {print $2}').upcase.chomp
end

def network_info
  $eth_mac = get_macaddr("en0")
  eth_ip4 = get_ip4addr("en0")
  $air_mac = get_macaddr("en1")
  air_ip4 = get_ip4addr("en1")

  puts   "Airport MAC:      " + $air_mac
  puts   "Airport Ip4Addr:  " + air_ip4

  puts   "Eth MAC:          " + $eth_mac
  puts   "Eth Ip4Addr:      " + eth_ip4
end

def audit_system(serial)
  result = get_info(gen_url(serial))
  report(serial, result)
end

# Stovocore

if ARGV.size > 0 then
  serial = ARGV.each do |serial|
    audit_system(serial.upcase)
  end
else
  audit_system(get_serial)
end
