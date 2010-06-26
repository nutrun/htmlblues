# For "Classic" style/top-level type of apps do something like: 
#
# configure :development do
#   require File.join(File.dirname(__FILE__), 'sinatra_reloader')
#   set :reload_paths, [File.join(File.dirname(__FILE__), '**', '*.rb')]
# end
#
# For "Modular" style/Sinatra::Base subclasses:
#
# configure :development do
#   require File.join(File.dirname(__FILE__), 'sinatra_reloader')
#   register Sinatra::Reloader
#   set :reload_paths, [File.join(File.dirname(__FILE__), '**', '*.rb')]
# end
#
# :reload_paths should be an array of path patterns where the
# source code intended for reloading resides.
# If not set, default is '<sinatra_reloader_dir>/**/*.rb'

module Sinatra
  module Reloader
    def self.extended(target)
      target.before { target.reload }
      default_path = File.expand_path(File.join(File.dirname(__FILE__), '**', '*.rb'))
      target.set(:reload_paths, [default_path])
    end
  
    def reload
      source_files = reload_paths.inject({}) do |paths, pattern|
        Dir[pattern].each { |path| paths[path] = File.mtime(path) }
        paths
      end
      return if source_files == @source_files
      @source_files = source_files
      routes.clear
      @source_files.keys.each { |path| load(path) }
    end  
  end
  
  register Reloader
end