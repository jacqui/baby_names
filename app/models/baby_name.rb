class BabyName < ActiveRecord::Base
  validates_presence_of :name, :gender, :year#, :total_count, :total_rank
  validates_inclusion_of :gender, :in => %w(female male), :message => 'is invalid'
  validates_numericality_of :total_count, :total_rank

  named_scope :by_ethnicity, lambda { |ethnicity| {:conditions => ["#{BabyName.count_column_for(ethnicity)} > 0"]}}

  named_scope :ordered_by_total_rank, lambda { |direction| { :order => "total_rank #{direction}" } }
  named_scope :ordered_by_total_count, lambda { |direction| { :order => "total_count #{direction}" } }

  named_scope :most_popular_by_gender, lambda { |gender|
    { :conditions => ["gender = ?", gender], :select => "baby_names.*, SUM(baby_names.total_count) as total", :group => "baby_names.name", :order => 'total DESC' }
  }
  named_scope :most_popular_by_ethnicity, lambda { |ethnicity |
    ethnicity_count = BabyName.count_column_for(ethnicity)
    { :conditions => ["#{ethnicity_count} > 0"], :select => "baby_names.*, SUM(baby_names.#{ethnicity_count}) as total", :group => "baby_names.name", :order => 'total DESC' }
  }
  named_scope :most_popular, { :select => "baby_names.*, SUM(baby_names.total_count) as total", :order => 'total DESC', :group => "baby_names.name" }
  named_scope :limit, lambda {|quantity| { :limit => quantity } }

  INCLUDED_ETHNICITIES = ['black', 'white', 'hispanic', 'asian', 'unknown']

  def self.count_column_for(ethnicity)
    return 'total_count' unless INCLUDED_ETHNICITIES.include?(ethnicity)
    "#{ethnicity}_count"
  end

  def female?
    gender == 'female'
  end

  def male?
    gender == 'male'
  end

  def gender=(value)
    self[:gender] = value.downcase
  end

  # dynamically create these setters as they're all the same & basic: ensure
  # value is an integer:)
#  %w(total_count unknown_count unknown_rank black_count black_rank white_count white_rank hispanic_count hispanic_rank asian_count asian_rank).each do |method_name|
#    define_method("#{method_name}=") do |value|
#      self["#{method_name}"] = value.to_i
#    end
#  end
end
