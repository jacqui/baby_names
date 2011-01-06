require 'rubygems'
namespace :populate do
  desc "Populate the DB with names from the CSV located at RAILS_ROOT/db/data/babynames1920-2008.csv"
  task :names do
    require 'baby_parser'
    BabyParser.names_from_csv
  end

  desc "Populate the DB with names from the CSV located at RAILS_ROOT/db/data/babynamesethnicity1990-2008.csv"
  task :ethnicity do
    require 'baby_parser'
    BabyParser.ethnicity_from_csv
  end

  desc "Load data using the csv straight up!"
  task :infile => :environment do
    require 'baby_parser'
    puts "loading baby name data..."
    ActiveRecord::Base.connection.execute("LOAD DATA LOCAL INFILE '#{File.join(RAILS_ROOT, 'db', 'data', 'babynames1920-2008.csv')}' INTO TABLE baby_names(year,gender,name,total_count,total_rank) FIELDS TERMINATED BY ',' IGNORE 1 LINES")
    puts "... done!"
  end
end
