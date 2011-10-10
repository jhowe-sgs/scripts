#!/opt/local/bin/ruby

require 'rubygems'
require 'nokogiri'

def dump_content(array, domain)
        array.each do |a|
                puts "#{a}@#{domain}    OK"
        end
end

mailserver="../../../Kerio/mailserver.cfg"
users="../../../Kerio/users-fixed.cfg"

f = File.open(mailserver)
@mailserver = Nokogiri::XML(f)
f.close

f = File.open(users)
@users = Nokogiri::XML(f)
f.close

domain = @mailserver.xpath("/config/list[@name='Domain']/listitem/variable[@name='Type'][.=0]/../variable[@name='Domain']/text()")

puts "# Using domain: #{domain}"

puts "# Mailing Lists"

lists = @mailserver.xpath("/config/list[@name='MailingList']/listitem/variable[@name='Domain'][.='#{domain}']/../variable[@name='Name']/text()").map(&:text).sort

dump_content(lists, domain)

puts "# Scheduling Resources"

resources = @mailserver.xpath("/config/list[@name='Resource']/listitem/variable[@name='Domain'][.='#{domain}']/../variable[@name='Type'][.=0]/../variable[@name='Name']/text()").map(&:text).sort

dump_content(resources, domain)

puts "# Aliases"

aliases = @users.xpath("/config/list[@name='Alias']/listitem/variable[@name='Domain'][.='#{domain}']/../variable[@name='Lhs']/text()").map(&:text).sort

dump_content(aliases, domain)

puts "# Groups"

groups = @users.xpath("/config/list[@name='Group']/listitem/variable[@name='Domain'][.='#{domain}']/../variable[@name='MailAddress']/text()").map(&:text).sort

dump_content(groups, domain)

puts "# Users"

users = @users.xpath("/config/list[@name='User']/listitem/variable[@name='Domain'][.='#{domain}']/../variable[@name='Account_enabled'][.=1]/../variable[@name='Name']/text()").map(&:text).sort

dump_content(users, domain)
