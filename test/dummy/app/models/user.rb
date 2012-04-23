class User < ActiveRecord::Base
  belongs_to  :package
  has_many  :albums
  
  ari_options :functions => ['inspect']
  
  def foo1
    return "[#{self.name} : #{self.package_id}]"
  end
end