# encoding: utf-8
require 'open-uri'
require 'rubygems'
require 'bundler'
Bundler.require

class App < Sinatra::Base

  register Sinatra::WeiXinRobot

  configure do
    enable  :logging
    set     :weixin_token, ""
    set     :weixin_uri,   ""
  end
  def getchange(receive_content)
    url = "http://download.finance.yahoo.com/d/quotes.csv?e=.csv&f=sl1d1t1&s=USDCNY=x"
    urldup = url.dup
    changeurl = urldup.sub("USDCNY",receive_content)
    q = open(changeurl)
    change = q.read
    q.close
    return change
  end

  get "#{settings.weixin_path}" do
    "#{params[:echostr]}"
  end

  post "/" do
    weixin = message_receiver(request.body)
    nowchange = getchange(weixin.content.upcase)
    weixin.sender(:msg_type => "text") do |msg|
      msg.content = nowchange
      msg.complete!
      msg.to_xml
    end
  end
end
