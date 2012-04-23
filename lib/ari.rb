module Ari
  autoload :ModelHelpers, 'ari/active_record'
  autoload :Inspector, 'ari/inspector'
  
  ActiveRecord::Base.send(:include, Ari::ModelHelpers)
end