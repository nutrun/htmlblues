require "fileutils"
require "rest_client"
require "find"

class SinatraToStaticHtml
  def initialize(paths=[], outdir=File.join(File.dirname(__FILE__), '..', 'out'))
    @paths, @outdir = paths, File.expand_path(outdir)
  end
  
  def make_html
    @paths.each do |path|
      dir = File.join(@outdir, File.dirname(path))
      content = RestClient.get("http://0.0.0.0:4567#{path}")
      FileUtils.mkdir_p(dir)
      File.open(File.join(dir, File.basename(path)), 'w') { |f| f << content }
    end
  end
  
  def copy_public_artifacts
    pubdir = File.join(File.dirname(__FILE__), '..', 'public', '*')
    Dir[pubdir].each { |e| FileUtils.cp_r(e, @outdir) }
  end
  
  def clean
    FileUtils.rm_rf(@outdir)
  end
  
  def self.make
    require File.expand_path(File.join(File.dirname(__FILE__), 'sitemap'))
    routes = Sinatra::Application.routes["GET"].map { |i| i[0].to_s }
    paths = routes.map { |r| r.match(/\?\-mix\:\^\\(.*)\$/)[1].gsub('\\', '') }
    inst = self.new(paths)
    inst.make_html
    inst.copy_public_artifacts
  end
  
  def self.clean
    self.new.clean
  end
end
