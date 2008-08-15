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
      include ClassMethods
    end
    
    module ClassMethods
      bindtextdomain "iso_countries", :path => "#{File.dirname(__FILE__)}/../locale"
      
      # Sets the language for country translation
      def set_language(lang)
        @@language = lang
        GetText.locale = lang
      end
      
      # Gets te current translation language
      def language
        @@language || "en"
      end
      
      # Wrapper to get country name from country code. +code+ can be a symbol or a string containing the country code.
      def get_country(code)
        _(COUNTRIES[code.to_sym]) rescue nil
      end
      
      # Wrapper to get country code from country name.
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
  end
end