require 'open-uri'
require 'rubygems'
require 'sinatra/base'
require 'erb'

class Platform < Sinatra::Base
  set :views, File.dirname(__FILE__)
  set :public_folder, File.dirname(__FILE__)
  url = "http://download.finance.yahoo.com/d/quotes.csv?e=.csv&f=sl1d1t1&s=USDCNY=x"

  get "/" do
    open(url){ |f| return f.read}
  end

  get "/hello/:change" do
    urldup = url.dup
    changeurl = urldup.sub("USDCNY",params[:change])
    open(changeurl){ |f| return f.read}
  end

  get "/world/" do
    signature = params[:signature]
    timestamp = params[:timestamp]
    nonce = params[:nonce]
    echostr = params[:echostr]
    echostr
  end

  post "/world/" do
    if generate_signature == params[:signature]
      receiver = message_receiver(request.body)  # 得到用户向机器人发送的信息.  receiver.content 可以得到具体内容。
      xml = receiver.sender do |r|
        r.msg_type = "text"  #指定发送的信息类型.
        r.content = "你好。我是机器人。"
        r.complete! # 最后返回Reply这个对象，用来转换xml
      end
      xml.to_xml # 创建返回xml，结束。
    end
  end

end