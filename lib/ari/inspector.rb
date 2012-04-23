module Ari
  module Inspector
    
    # TODO - find smarter method to resolve non-conventional file/model names
    def self.collect_models
      models = []
      
      # touch classes (to preload them)
      Dir["app/models/**/*.rb"].each do |model_file|
        print "Resolving model : #{model_file} ... "
        begin
          File.basename(model_file, '.rb').camelize.constantize
        rescue
          puts "ERROR"
          # Silent night, holy night, .... - skip files 
        end
        puts "DONE"
      end
      
      ActiveRecord::Base.descendants.each do |desc|
        models << { :model => desc.name, :table => desc.table_name, :count => desc.count} if desc.table_exists?
      end
      
      return models.sort! {|a, b| a[:model] <=> b[:model]}
    end
    
    def self.inspect_data(model_name, method, where_clause, parent_model_name, parent_id, belongs, collection, offset)
      offset ||= 0
      collection ||=  true
      where_clause ||= ''
      
      
      model_class = eval(model_name)
      columns = model_class.columns

      puts "GET GET"
      ari_functions  = model_class.ari_functions
      ari_exclude    = model_class.ari_exclude
      
      columns = model_class.columns
      rows = []
      count = 0
      sql = ''

      if (belongs.nil?)
        if (where_clause)
          rows = model_class.where(where_clause).limit(10).offset(offset).order(:id)
          sql = "#{model_name}.where(#{where_clause})"
          count = model_class.where(where_clause).count()
        else
          rows = model_class.send(method).limit(10).offset(offset).order(:id)
          sql = "#{model_name}.#{method}()"
          count = model_class.send(method).count()
        end
      else
        parent_model_class = eval(parent_model_name)
        parent_model = parent_model_class.find(parent_id)
        result = nil
        if (collection == 'true')
          result = parent_model.send(method).limit(10).offset(offset).order(:id)
          sql = "#{parent_model_name}.find(#{parent_id}).#{method}()"
          count = parent_model.send(method).count()
          rows = result if result != nil
        else 
          result = parent_model.send(method)
          sql = "#{parent_model_name}.find(#{parent_id}).#{method}()"
          rows = [result] if result != nil
        end
      end

      belongs_to_relations = {}
      has_relations = {}
      model_class.reflect_on_all_associations.each do |rel|
        begin
          if (rel.belongs_to?)
            belongs_to_relations[rel.association_foreign_key] = rel
          else
            has_relations[rel.name.to_s] = rel
          end
        rescue
        end
      end

      inspected_data = {
        :columns => [],
        :rows => [],
        :count => count,
        :sql => sql
      }

  		columns.each do |column|
  			rel = belongs_to_relations[column.name]
  			
  			label = rel ? rel.name : column.name
  			
  			if (ari_exclude[label].nil?)
    			if rel
    			  inspected_data[:columns] << { :label => label, :type => :bt }
    			else
    			  inspected_data[:columns] << { :label => label, :type => :simple }
    			end
    		end
  		end
  		has_relations.each do |name, rel|
  			if (ari_exclude[rel.name].nil?)
  		    inspected_data[:columns] << { :label => rel.name, :type => :has }
		    end
  		end
  		
  		ari_functions.each do |funct, dummy|
  		  inspected_data[:columns] << { :label => funct, :type => :function }
		  end


      rows.each do |row|
        one_row = []

    		columns.each do |column|
    		  rel = belongs_to_relations[column.name]
    			if rel
    				if row[column.name]
    				  one_row << { :type =>:bt, :label => row[column.name], :params => {:parent_model =>model_name, :parent_id => row.id, :model => rel.class_name, :method => rel.name, :collection => rel.collection?.to_s, :belongs_to => true} }
    				else
    				  one_row << { :type =>:bt, :label => '', :params => {:parent_model =>model_name, :parent_id => row.id, :model => rel.class_name, :method => rel.name, :collection => rel.collection?.to_s, :belongs_to => true} }
    				end
    			else
    				if column.name == 'id'
    				  one_row << { :type => :id, :label => row[column.name], :params => {:model => model_name, :where => "id=#{row[column.name]}" } }
    				else
    				  one_row << { :type => :simple, :label => row[column.name] }
    				end
    			end
    		end

    		has_relations.each do |name, rel|
    		  one_row << {:type => :has, :label => rel.name, :params => {:parent_model => model_name, :parent_id => row.id, :model => rel.class_name, :method => rel.name, :collection => rel.collection?.to_s, :belongs_to => 'false' }}
    		end
    		
    		ari_functions.each do |funct, dummy|
				  one_row << { :type => :function, :label => row.send(funct) }
  		  end
    		

    		inspected_data[:rows] << one_row
      end

      return inspected_data

    end    
    
    
  end
end