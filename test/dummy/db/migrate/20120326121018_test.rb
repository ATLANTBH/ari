class Test < ActiveRecord::Migration
  def up
    create_table  :users do |t|
      t.string  :name
      t.references  :package
    end
    
    create_table :packages do |t|
      t.string  :name
    end
    
    create_table  :albums do |t|
      t.string :name
      t.references  :user
    end
  end

  def down
  end
end
