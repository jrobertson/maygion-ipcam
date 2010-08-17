#!/usr/bin/ruby

# file: maygion-ipcam.rb

require 'net/http'
require 'open-uri'

class MayGionIPCam

  attr_reader :resp

  def initialize(opt)
    o = {username: 'user', password: 'user', address: '192.168.1.14', port: 80}.merge(opt)
    @addr, @port = o[:address], o[:port]
    @raw_url = "http://#{@addr}/cgi.cmd?cmd=moveptz&tick=100&user=user&pwd=user"
    @resp, data = login(o[:username], o[:password])
    @cookie = @resp.response['set-cookie'].scan(/\w+\=[^=]+(?=;)/).join(';')
  end

  def left(i=1)
    move_camera '&dir=btnPtzLeft&nPtzTimes=' + i.to_s
  end

  def right(i=1)
    move_camera '&dir=btnPtzRight&nPtzTimes=' + i.to_s
  end

  def up(i=1)
    move_camera '&dir=btnPtzUp&nPtzTimes=' + i.to_s
  end

  def down(i=1)
    move_camera '&dir=btnPtzDown&nPtzTimes=' + i.to_s
  end

  def login(username, password)

    http = Net::HTTP.new(@addr, @port)
    path = '/cgi-bin/cgicmd'

    # POST request -> logging in
    data = 'szAccount=user&szPassword=user&cmd=Login&urlOnSuccess=/mobile.asp'
    headers = {
      'Referer' => "http://#{@addr}/login.asp",
      'Content-Type' => 'application/x-www-form-urlencoded'
    }

    http.post(path, data, headers)
  end

  def move_camera(instruction)
    url = @raw_url + instruction
    open(url, 'UserAgent' => 'Ruby IPCO (IP Camera Operator)', 'Cookie' => @cookie).read
  end
end
