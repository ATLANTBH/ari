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
        @ari_functions  ||= {}
        @ari_exclude    ||= {}
        options[:exclude].each { |x| @ari_exclude[x] = true } if options[:exclude]
        options[:functions].each { |x| @ari_functions[x] = true } if options[:functions]
      end

      def ari_functions
        return @ari_functions || {}
      end

      def ari_exclude
        return @ari_exclude || {}
      end
      
    end
  end
end
