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
    changeurl = url.dup
    q = changeurl.sub("USDCNY",params[:change])
    open(q){ |f| return f.read}
  end

  get "/world/" do
    signature = params[:signature]
    timestamp = params[:timestamp]
    nonce = params[:nonce]
    echostr = params[:echostr]
    echostr
  end

end