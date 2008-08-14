require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the iso_countries plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the iso_countries plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'IsoCountries'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Download an updated list from the iso website'
task :update do
  url = "http://www.iso.org/iso/iso3166_en_code_lists.txt"
  require 'open-uri'
  iso = open(url)
  require "iconv"
  conv = Iconv.new('utf8', 'latin1')
  require "unicode"

  File.open('lib/country_list.rb', 'w')  do |f|
    f.puts "module ISO"
    f.puts "  module Countries"
    f.puts "    COUNTRIES = {"
    
    # Skip the first two lines, as they don't contain country information
    iso.readline
    iso.readline
    
    countries = []
    iso.each_line do |line|
      country, code = line.split(';')
      code.chomp!
      country = Unicode.capitalize(conv.iconv(country))
      
      puts "#{code} => #{country}"
      countries << "      :#{code.downcase} => N_(\"#{country}\")"
    end
    f.puts countries.join(",\n")
    
    f.puts "  }"
    f.puts "  end"
    f.puts "end"
  end
  
end

desc "Update pot/po files to match new version." 
task :updatepo do
  require 'gettext'
  require 'gettext/utils'  

  # GetText::ActiveRecordParser.init(:use_classname => false, :activerecord_classes => ['FakeARClass'])
  GetText.update_pofiles('iso_countries', 
                         Dir.glob("lib/**/*.rb"),
                         "iso_countries plugin")
end

desc "Create mo-files"
task :makemo do
  require 'gettext'
  require 'gettext/utils'  
  GetText.create_mofiles(true, "po", "locale")
end