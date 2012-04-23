module Ari
  module ModelHelpers
    extend ActiveSupport::Concern
    
    module ClassMethods

      #
      # options:
      #     :exclude   => ['column_name', 'relation_name']
      #     :functions => ['function']
      #
      def ari_options(options = {})
        puts "ARI OPTIONS"
        @ari_functions  ||= {}
        @ari_exclude    ||= {}
        options[:exclude].each { |x| @ari_exclude[x] = true } if options[:exclude]
        options[:functions].each { |x| @ari_functions[x] = true } if options[:functions]
        puts "ARI OPTIONS INSPECT : #{@ari_functions} : #{@ari_exclude}"
      end

      def ari_functions
        puts "GET FOOS"
        return @ari_functions || {}
      end

      def ari_exclude
        puts "GET EXS"
        return @ari_exclude || {}
      end
      
    end
  end
end