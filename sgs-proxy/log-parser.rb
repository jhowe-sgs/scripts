#!/opt/local/bin/ruby

require 'mongo_mapper'
# require 'pp'

MongoMapper.database = 'sgs-squid'

class Log
  include MongoMapper::Document

  # key types: String, Integer, Array, Boolean, Time

  key :date, String
  key :time, String
    key :datetime, Time
  key :computer, String
  key :ipaddr, String
  #key :url, String
    key :domain, String
  key :filter_action, String 
  key :filter_reason, String
  key :filter_sub_reason, String
  key :method, String
  key :request_size, Integer
  key :weight, Integer
  key :category, String
  key :filter_group, Integer
  key :http_code, Integer
  key :mimetype, String
  key :client_name, String
  key :filter_name, String
  #key :user_agent, String
end

#Zlib::GzipReader.open('test.txt.gz') do |gz|
#  gz.each_line do |line|
#    puts "Here is line #{line}"
#  end
#end

# dansguardian format
# => Date   YYYY.M.D            $ 2012.3.11
# => Time   HH:MM:SS            $ 4:04:00
# => Requesting User|Computer   $ 10.0.0.45
# => Requesting IP              $ 10.0.0.45
# => Requested URL              $ http://um14.eset.com/eset_upd/v4/update.ver 
# => ( filter actions )         $ '',*DENIED*,*EXCEPTION*
# => ( reason )                   (), Banned Site:, 
# => ( sub reason )               (), domain.tld||Blanket IP
# => HTTP Method                $ GET|HEAD|POST|PROPFIND|PUT|OPTIONS
# => Req Size                   $ 4301
# => Weighted Phrase Score      $ 0
# => ( Category )               $  '',
# => Filter Group # =>          $ 1
# => HTTP Return Code           $ 200
# => mimetype                   $ application/octet-stream
# => ( clientname )             $  '',
# => filter group name          $ Default
# => user agent string          $ -

puts "Collection remove"

Log.collection.remove

logfile = "dansguardian-access.log.1"

total = %x{wc -l #{logfile}}.split.first.to_i

counts = {}

begin
  count = 0
  file = File.new(logfile, "r:iso-8859-1:utf-8")
  while ( line = file.gets )
    count = count + 1

    if (( count % 50000 ) == 0 )
      puts "Processed #{count} lines out of #{total}"
    end

    # Strip trailing User Agent entry

    line.gsub!(/\ -$/,'')

    # Name Sanitize Filter groups
    line.gsub!(/5th Grade/, '5th_Grade')
    line.gsub!(/6th Grade/, '6th_Grade')
    line.gsub!(/7th Grade/, '7th_Grade')
    line.gsub!(/8th Grade/, '8th_Grade')

    # See Dans Guardian SRC data/languages/ukenglish/messages 

    # "200","The requested URL is malformed."

    # "400","Banned combination phrase found: "
    line.gsub!(/Banned combination phrase found\:/, 'Banned_Combo_Phrase_Found')
    # "401","Banned combination phrase found."
    line.gsub!(/Banned combination phrase found\./, 'Banned_Combo_Phrase_Found')
    # "402","Weighted phrase limit of "
    line.gsub!(/Weighted phrase limit of/, 'Weighted_Phrase_Limit_Of')
    # "403","Weighted phrase limit exceeded."
    line.gsub!(/Weighted phrase limit exceeded\./, 'Weighted_Phrase_Limit_Exceeded')

    # 500
    line.gsub!(/Banned site\:/, 'Banned_Site')
    # 501
    line.gsub!(/Banned URL\:/, 'Banned_URL')
    # "503","Banned Regular Expression URL: "
    line.gsub!(/Banned Regular Expression URL\:/, 'Banned_Regex_URL')
    # "504","Banned Regular Expression URL found."
    line.gsub!(/Banned Regular Expression URL found\./, 'Banned_Regex_URL_Found')
    # 505
    line.gsub!(/Blanket IP Block is active and that address is an IP only address\./, 'Blanket_IP_Block_Active')

    # EXCEPTIONS

    # 600
    line.gsub!(/Exception client IP match\./, 'Exception_Client_IP_Match')
    # 602
    line.gsub!(/Exception site match\./, 'Exception_Site_Match')
    # 603
    line.gsub!(/Exception URL match\./, 'Exception_URL_Match')
    # "606","Bypass URL exception."
    line.gsub!(/Bypass URL exception\./, 'Bypass_URL_Exception')

    # "800","Banned MIME Type: "
    # "900","Banned extension: "
    # "1000","PICS labeling level exceeded on the above site."
    # "1100","Virus or bad content detected."
    # "1101","Advert blocked"

    a = line.split(/\s/)
    size = a.size

    year,month,day = a[0].split("\.")
    hh,mm,ss = a[1].split("\:")
    date_time = Time.local(year,month,day,hh,mm,ss)

    last=a[4].split("\/")[2].split("\.").last
    tlds = [ "com", "net", "org", "info", "biz" ]
    if tlds.any? { |tld| last.include?(tld) }
      domain = a[4].split("\/")[2].split("\.").last(2).join(".")
    else
      # What about IP_Addresses?
      domain = a[4].split("\/")[2].split("\.").last(3).join(".")
    end

    # Make Mongo Entries if recognized
    if a[5] == ''
      # Site passed filter, size = 15
      Log.create(
        :date               => a[0],
        :time               => a[1],
          :datetime         => date_time,
        :computer           => a[2],
        :ipaddr             => a[3],
        :url                => a[4],
          :domain           => domain.downcase,
        :filter_action      => a[5],
        #:filter_reason  
        #:filter_sub_reason
        :method             => a[6],
        :request_size       => a[7],
        :weight             => a[8],
        :category           => a[9],
        :filter_group       => a[10],
        :http_code          => a[11],
        :mimetype           => a[12],
        :client_name        => a[13],
        :filter_name        => a[14]
      )
    elsif a[5] == '*DENIED*'
      # size = 17
      if a[6] =~ /Banned/
        # ~ Banned_URL domain.tld/url
        # ~ Banned_Site domain.tld
        # ~ Banned_Site Blanket_IP_Block
        Log.create(
          :date               => a[0],
          :time               => a[1],
            :datetime         => date_time,
          :computer           => a[2],
          :ipaddr             => a[3],
          :url                => a[4],
            :domain           => domain.downcase,
          :filter_action      => a[5],
          :filter_reason      => a[6],
          :filter_sub_reason  => a[7],
          :method             => a[8],
          :request_size       => a[9],
          :weight             => a[10],
          :category           => a[11],
          :filter_group       => a[12],
          :http_code          => a[13],
          :mimetype           => a[14],
          :client_name        => a[15],
          :filter_name        => a[16]
        )
      elsif a[6] =~ /Weighted_Phrase_Limit/
        puts "I don't know how to process this denial: #{count}: #{line}"
      else
        puts "I don't know this denial: #{count}: #{line}"
      end
    elsif a[5] == '*EXCEPTION*'
      # size = 16
      if a[6] =~ /Exception_Site_Match/ or a[6] =~ /Exception_URL_Match/
        # Exception site match. 
        # Exception URL match.
        Log.create(
          :date               => a[0],
          :time               => a[1],
            :datetime         => date_time,
          :computer           => a[2],
          :ipaddr             => a[3],
          :url                => a[4],
            :domain           => domain.downcase,
          :filter_action      => a[5],
          :filter_reason      => a[6],
          #:filter_sub_reason
          :method             => a[7],
          :request_size       => a[8],
          :weight             => a[9],
          :category           => a[10],
          :filter_group       => a[11],
          :http_code          => a[12],
          :mimetype           => a[13],
          :client_name        => a[14],
          :filter_name        => a[15]
        )
      else
        # unknown exception
        puts "I don't know this exception: #{count}: #{line}"
        next
      end
    else
      puts "I don't know this filter: #{count}: #{line}"
      next
    end
  end
  file.close
rescue => err
  puts "Exception: #{err}"
  err
end

# pp counts.sort
