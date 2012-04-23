class Package < ActiveRecord::Base
  has_many  :users
end