#!/usr/bin/env ruby

# file: maygion-ipcam.rb

require 'net/http'
require 'open-uri'

class MayGionIPCam

  attr_reader :resp, :cookie
  Factor = 500
  
  def initialize(opt)
    
    o = {username: 'user', password: 'user', address: '192.168.1.14', \
         port: 80, cookie: ''}.merge(opt)
    @addr, @port = o[:address], o[:port]
    @raw_url = "http://#{@addr}/cgi.cmd?cmd=moveptz&user=" + o[:username] \
        + "&pwd=" + o[:password]
    @cookie = o[:cookie]
    
    if @cookie.empty? then
      @resp, data = login(o[:username], o[:password])
      @cookie = @resp.response['set-cookie'].scan(/\w+\=[^=]+(?=;)/).join(';')
    end
  end

  def left(i=1)
    move_camera "&dir=btnPtzLeft&tick=%s&nPtzTimes=1" %  [i * Factor]
  end

  def right(i=1)
    move_camera "&dir=btnPtzRight&tick=%s&nPtzTimes=1" %  [i * Factor]
  end

  def up(i=1)
    move_camera "&dir=btnPtzUp&tick=%s&nPtzTimes=1" %  [i * Factor]
  end

  def down(i=1)
    move_camera "&dir=btnPtzDown&tick=%s&nPtzTimes=1" %  [i * Factor]
  end

  def login(username, password)

    http = Net::HTTP.new(@addr, @port)
    path = '/cgi-bin/cgicmd'

    # POST request -> logging in
    data = "szAccount=#{username}&szPassword=" + password +  
        "&cmd=Login&urlOnSuccess=/mobile.asp"
    headers = {
      'Referer' => "http://#{@addr}/login.asp",
      'Content-Type' => 'application/x-www-form-urlencoded'
    }

    http.post(path, data, headers)
  end

  def move_camera(instruction)
    url = @raw_url + instruction
    URI.open(url, 'UserAgent' => 'Ruby IPCO (IP Camera Operator)', \
         'Cookie' => @cookie){|x| x.read}
  end
  
  def snap()
    
    url = "http://#{@addr}/snap.jpg"
    URI.open(url, 'UserAgent' => 'Ruby IPCO (IP Camera Operator)', \
         'Cookie' => @cookie){|x| x.read}

  end
end
