require "rubygems"
require "sinatra"
require "erb"
require File.expand_path(File.join(File.dirname(__FILE__), 'sinatra_reloader'))

set :views, File.join(File.dirname(__FILE__), '..', 'views')
set :public, File.join(File.dirname(__FILE__), '..', 'public')

get('/index.html') { erb :index }
get('/howto/1.html') { erb :'howto/1' }
