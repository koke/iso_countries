# IsoCountries

#
# Placeholder methods if gettext is not being used
#
unless defined?(_)
  def _(msg)
    msg
  end
end

unless defined?(N_)
  def N_(msg)
    msg
  end
end

###

require "country_list"
require "iso/countries/form_helpers"
ActiveRecord::Base.send :include, ISO::Countries::CountryField

module ISO
  module Countries
    class << self
      # Wrapper to get country name from country code. +code+ can be a symbol or a string containing the country code.
      # *Warning*: this functions returns the untranslated name, you have to apply _() manually.
      def get_country(code)
        COUNTRIES[code.to_sym] rescue nil
      end
      
      def get_code(name)
        if COUNTRIES.value?(name)
          COUNTRIES.each_pair do |k,v|
            if v.eql?(name)
              return k.to_s
            end
          end
        end
      end
    
      # Returns an array with all the available country codes
      def country_codes
        COUNTRIES.keys.map { |key| key.to_s }
      end
    end
  
    module CountryHelper
      def country_format(code)
        _(COUNTRIES[code.to_sym])
      end
    end
  end
end