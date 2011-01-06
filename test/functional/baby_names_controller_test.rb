require File.dirname(__FILE__) + '/../test_helper'

class BabyNamesControllerTest < ActionController::TestCase

  context "#index" do
    setup do
      @female_name = Factory(:baby_name, :gender => 'female', :year => '1985')
      @male_name = Factory(:baby_name, :gender => 'male', :year => '1990')
    end

    should "return all baby names when no parameters specified" do
      get :index
      assert_same_elements [@female_name, @male_name], assigns['baby_names']
    end

    should "return all female baby names when gender = female" do
      get :index,  :gender_equals => 'female'
      assert_same_elements ['female'], assigns['baby_names'].map(&:gender).uniq
    end

    should "return all male baby names when gender = male" do
      get :index,  :gender_equals => 'male'
      assert_same_elements ['male'], assigns['baby_names'].map(&:gender).uniq
    end

    should "return all baby names for a given year" do
      get :index,  :year_equals => '1990'
      assert_same_elements ['1990'], assigns['baby_names'].map(&:year).uniq
    end

    should "return all baby names for a given ethnicity" do
      get :index,  :by_ethnicity => 'asian'
    end
  end


end
