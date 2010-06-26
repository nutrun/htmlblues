require 'rake/contrib/sshpublisher'
require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'sinatra_to_static_html'))

task :default => :make

desc 'Generate static html'
task :make do
  SinatraToStaticHtml.make
end

desc 'Delete generated html'
task :clean do
  SinatraToStaticHtml.clean
end

desc 'Copy site to a server'
task :deploy do
  puts "Uncomment and edit Rakefile:19 to enable"
  # Rake::SshDirPublisher.new('you@yourserver.com', '/var/www/whatevs', 'out').upload
end
