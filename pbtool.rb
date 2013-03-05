require 'pinboard_api'
require 'net/http'

def check_url(url)
  begin
    url = URI.parse(url)
    req = Net::HTTP.new(url.host, url.port)
    res = req.request_head(url.path)
  rescue
    # error occured, return false
    false
  else
    # valid site
    true
  end
end       

def check_list(username, password)
  PinboardApi.username = username
  PinboardApi.password = password

  save_url = Array.new

  # Load all pinboard records
  pinboard = PinboardApi::Post.all

  pinboard.each do |post_rec|
    url = post_rec.url
    if check_url(url)
      print '.' 
    else
      print 'x'
      save_url.push url
    end 
  end
  puts "Invalid URLs:"
  save_url.each do |url|
    puts url
  end

end

check_list("stott", "xxxx")
