# IsoCountries

require "rubygems"
require "gettext"
include GetText
stubs = %w(activesupport activerecord actionpack actionmailer activeresource)
stubs.each do |stub|
  require stub
end

require "country_list"
require "iso/countries/form_helpers"
require "iso/countries/country_field"
ActiveRecord::Base.send :include, ISO::Countries::CountryField

module ISO
  module Countries
    class << self
      
      bindtextdomain "iso_countries", :path => "#{File.dirname(__FILE__)}/../locale"
      
      def set_language(lang)
        @@language = lang
        GetText.locale = lang
      end
      
      def language
        @@language || "en"
      end
      
      # Wrapper to get country name from country code. +code+ can be a symbol or a string containing the country code.
      # *Warning*: this functions returns the untranslated name, you have to apply _() manually.
      def get_country(code)
        _(COUNTRIES[code.to_sym]) rescue nil
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