require File.dirname(__FILE__) + '/../test_helper'

class BabyNameTest < ActiveSupport::TestCase
  should_have_db_column :name
  should_have_db_column :gender
  should_have_db_column :year
  should_have_db_column :hispanic_count
  should_have_db_column :hispanic_rank
  should_have_db_column :white_count
  should_have_db_column :white_rank
  should_have_db_column :black_count
  should_have_db_column :black_rank
  should_have_db_column :unknown_count
  should_have_db_column :unknown_rank
  should_have_db_column :total_count
  should_have_db_column :total_rank

  should_validate_presence_of :name, :gender, :year, :total_count, :total_rank
  should_allow_values_for :gender, 'female', 'male'
  should_not_allow_values_for :gender, 'foo', 'bar'
  should_validate_numericality_of :year, :total_count, :total_rank

  context "ranking" do
    setup do
      @valerie90 = Factory(:baby_name, :name => 'Valerie', :gender => 'female', :year => '1990', :total_count => 10, :total_rank => 1)
      @valerie80 = Factory(:baby_name, :name => 'Valerie', :gender => 'female', :year => '1980', :total_count => 7, :total_rank => 4, :black_count => 100, :black_rank => 1)
      @jennie90 = Factory(:baby_name, :name => 'Jennie', :gender => 'female', :year => '1990', :total_count => 5, :total_rank => 2, :black_count => 100, :black_rank => 1)
      @aimee90  = Factory(:baby_name, :name => 'Aimee', :gender => 'female', :year => '1990', :total_count => 1, :total_rank => 3, :black_count => 50, :black_rank => 2)
      @thomas90 = Factory(:baby_name, :name => 'Thomas', :gender => 'male', :year => '1990', :total_count => 10, :total_rank => 1)
      @nick90 = Factory(:baby_name, :name => 'Nick', :gender => 'male', :year => '1990', :total_count => 5, :total_rank => 2)
      @leonard90 = Factory(:baby_name, :name => 'Leonard', :gender => 'male', :year => '1990', :total_count => 1, :total_rank => 3)
      @leonard80 = Factory(:baby_name, :name => 'Leonard', :gender => 'male', :year => '1980', :total_count => 10, :total_rank => 5)
      @pj70 = Factory(:baby_name, :name => 'PJ', :gender => 'female', :year => '1970', :total_count => 10, :total_rank => 1, :black_count => 100, :black_rank => 1)
    end
    should "return all names in order of rank for a given year, both genders by default" do
      names = BabyName.by_year('1990').ordered_by_total_rank('ASC')
      assert_equal @valerie90, names.select(&:female?).first
      assert_equal @thomas90, names.select(&:male?).first
      assert_equal [@valerie90, @jennie90, @aimee90], names.select(&:female?)
      assert_equal [@thomas90, @nick90, @leonard90], names.select(&:male?)
    end
    should "return all names in order of rank for a given year and gender" do
      female_names = BabyName.by_year('1990').by_gender('female').ordered_by_total_rank('ASC')
      assert_equal @valerie90, female_names.first
      male_names = BabyName.by_year('1990').by_gender('male').ordered_by_total_rank('ASC')
      assert_equal @thomas90, male_names.first
      assert_equal [@valerie90, @jennie90, @aimee90], female_names
      assert_equal [@thomas90, @nick90, @leonard90], male_names
    end
    should "return most popular name across all years for a given gender" do
      names = BabyName.most_popular_by_gender('female', 10)
      assert_equal 'Valerie', names.first.name
      assert_equal 'PJ', names[1].name
      names = BabyName.most_popular_by_gender('male', 10)
      assert_equal 'Leonard', names.first.name
    end
    should "return most popular names" do
      names = BabyName.most_popular
      assert_equal 7, names.size
      assert_equal 'Valerie', names.first.name
      assert_equal 17, names.first.sum_total.to_i
      assert_equal 'Leonard', names[1].name
      assert_equal 11, names[1].sum_total.to_i
    end

    should "return most popular names across all years (1990-2008) for a given ethnicity" do
      assert_equal 'Valerie', BabyName.most_popular_by_ethnicity('black').first.name
    end
    should "return most popular names across all years in total if ethnicity is not in database" do
      assert_equal BabyName.most_popular, BabyName.most_popular_by_ethnicity('foobar')
    end
    should "return all names in order of rank for a given ethnicity and year" do
      assert_equal 'Valerie', BabyName.by_year('1980').most_popular_by_ethnicity('black').first.name
    end
    should "return all names in order of rank for a given ethnicity, gender and year" do
      assert_equal 'Valerie', BabyName.by_gender('female').by_year('1980').most_popular_by_ethnicity('black').first.name
    end
  end
end
