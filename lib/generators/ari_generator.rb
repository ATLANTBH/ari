require 'rails/generators'

class AriGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
                          
  def self.source_root
    @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates/'))
  end

  def create
    template "views/index.html.erb", File.join('app/views', 'ari', "index.html.erb")
    template "views/show.html.erb", File.join('app/views', 'ari', "show.html.erb")
    template "views/_styles.html.erb", File.join('app/views', 'ari', "_styles.html.erb")
    template "views/_paging.html.erb", File.join('app/views', 'ari', "_paging.html.erb")
    template "controllers/ari_controller.rb", File.join('app/controllers', 'ari_controller.rb')
  end
end
