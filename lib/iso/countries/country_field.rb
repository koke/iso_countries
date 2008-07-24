module ISO #:nodoc:
  module Countries #:nodoc:
    module CountryField
      def self.included(base) #:nodoc:
        base.extend ClassMethods
      end
      
      module ClassMethods
        def iso_country(*args)
          args.each do |f|
            class_eval <<-EOC
              
              validates_inclusion_of :#{f}, :in => ISO::Countries.country_codes
              
              def #{f}_name
                ISO::Countries.get_country(#{f})
              end
              
              def #{f}_name=(name)
                code = ISO::Countries.get_code(name)
                if code
                  self.#{f} = code
                else
                  raise ArgumentError, "Invalid country name"
                end
              end              
              
            EOC
          end
        end
      end
    end
  end
end