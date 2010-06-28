require "rubygems"
require "sinatra"
require "haml"
require File.expand_path(File.join(File.dirname(__FILE__), 'sinatra_reloader'))

set :views, File.join(File.dirname(__FILE__), '..', 'views')
set :public, File.join(File.dirname(__FILE__), '..', 'public')
set :haml, { :attr_wrapper => '"' }

get('/index.html') { haml :index }
get('/howto/1.html') { haml :'howto/1' }
get('/css/reset.css') { content_type 'text/css'; sass :'css/reset' }
get('/css/screen.css') { content_type 'text/css'; sass :'css/screen' }
