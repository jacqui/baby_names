require 'fastercsv'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
class BabyParser
  def self.names_from_csv
    file = File.join(RAILS_ROOT, 'db', 'data', 'babynames1920-2008.csv')
    #file = File.join(RAILS_ROOT, 'db', 'data', 'babynames_excerpt.csv')
    count = 0
    puts "Starting to import baby names with total rankings from #{file}..."
    FCSV.foreach(file, :headers => true) do |row|
      begin
        unless row['name'] =~ /^FEMALE|MALE$/i
          next if row['name'].blank?
          baby_name = BabyName.find_or_create_by_name_and_year_and_gender(row['name'].titleize, row['year of birth'], row['gender'])
          if baby_name.valid?
            baby_name.update_attributes(:total_count => row['count'], :total_rank => row['rank'], :gender => row['gender'])
            count += 1
            puts "Stored: #{baby_name.name} / #{baby_name.year} / #{baby_name.gender} with #{baby_name.total_count} count and #{baby_name.total_rank} rank."
          else
            puts "BabyName had errors: #{baby_name.errors.full_messages}"
          end
        end
      rescue Exception => e
        puts "Error: #{e.message}"
      end
    end
    puts "Done! Parsed #{count} baby names."
  end

  def self.ethnicity_from_csv
    file = File.join(RAILS_ROOT, 'db', 'data', 'babynamesethnicity1990-2008.csv')
    #file = File.join(RAILS_ROOT, 'db', 'data', 'babynamesethnicity_excerpt.csv')
    count = 0
    puts "Starting to import baby names with ethnicity rankings from #{file}..."
    FCSV.foreach(file, :headers => true) do |row|
      begin
        exit  if row['year of birth'] == '1950'
        unless row['name'] =~ /^FEMALE|MALE$/i
          next if row['name'].blank?
          baby_name = BabyName.find_or_create_by_name_and_year_and_gender(row['name'].titleize, row['year of birth'], row['gender'])
          hispanic_count = row['HISPANIC (count)'].to_i
          hispanic_rank  = hispanic_count == 0 ? 0 : row['HISPANIC (rank)']

          asian_count = row['ASIAN AND PACIFIC ISLANDER (count)'].to_i
          asian_rank = asian_count == 0 ? 0 : row['ASIAN AND PACIFIC ISLANDER (rank)']

          black_count = row['BLACK NON HISPANIC (count)'].to_i
          black_rank = black_count == 0 ? 0 : row['BLACK NON HISPANIC (rank)']

          white_count = row['WHITE NON HISPANIC (count)'].to_i
          white_rank = white_count == 0 ? 0 : row['WHITE NON HISPANIC (rank)']

          unknown_count = row['UNKNOWN (count)'].to_i
          unknown_rank  = unknown_count == 0 ? 0 : row['UNKNOWN (rank)']

          baby_name.update_attributes( :hispanic_count => hispanic_count,
                                        :hispanic_rank => hispanic_rank,
                                        :asian_count => asian_count,
                                        :asian_rank => asian_rank,
                                        :white_count => white_count,
                                        :white_rank => white_rank,
                                        :black_count => black_count,
                                        :black_rank => black_rank,
                                        :unknown_count => unknown_count,
                                        :unknown_rank => unknown_rank)
          count += 1
          puts "Stored ethnicity ranking and counts for #{baby_name.name} / #{baby_name.year} / #{baby_name.gender}"
        end
      rescue Exception => e
        puts "Error: #{e.message}"
      end
    end
    puts "Done! Parsed #{count} records"
  end
end
