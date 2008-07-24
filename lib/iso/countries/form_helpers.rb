module ActionView
  module Helpers
    module FormOptionsHelper
      def iso_country_select(object, method, priority_countries = nil, options = {}, html_options = {})
        InstanceTag.new(object, method, self).to_iso_select_tag(priority_countries, options, html_options)
      end

      def iso_options_for_select(selected = nil, priority_countries = nil)
        countries_for_select = {}
        ISO::Countries::COUNTRIES.each_pair {|code,name| countries_for_select[_(name)] = code.to_s }

        country_options = ""

        if priority_countries
          priority_hash = {}
          priority_countries.each {|code| priority_hash[ISO::Countries.get_country(code)] = code.to_s }
          country_options += options_for_select(priority_hash.sort, selected)
          country_options += "<option value=\"\">-------------</option>\n"
        end

        if priority_countries && priority_countries.include?(selected)
          country_options += options_for_select(countries_for_select.sort - priority_countries, selected)
        else
          country_options += options_for_select(countries_for_select.sort, selected)
        end

        return country_options
      end

      def to_iso_select_tag(priority_countries, options, html_options)
        if html_options.has_key?(:class)
          html_options[:class] = html_options[:class] + " country"
        else
          html_options[:class] = "country"
        end
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select", add_options(iso_options_for_select(value, priority_countries), options, value), html_options)
      end  
    end
  end
end
