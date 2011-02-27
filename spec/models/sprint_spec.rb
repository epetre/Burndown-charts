require 'spec_helper'

describe Sprint do
  it "fails validation with no total points (using error_on)" do
    Sprint.new.should have(3).error_on(:total_points)
  end

  it "fails validation with no start date (using errors_on)" do
    Sprint.new.should have(1).error_on(:start_date)
  end

  it "passes validation with a start date (using 0)" do
    Sprint.new(:start_date => Date.new).should have(0).error_on(:start_date)
  end

  it "passes validation with total points (using :no)" do
    Sprint.new(:total_points => 25).should have(:no).error_on(:total_points)
  end
  
  it "fails validation with no total points (using :no)" do
    Sprint.new(:total_points => 25).should have(:no).error_on(:total_points)
  end
  
  it "fails validation when total points is not an integer higher than 0 (using 2)" do
    Sprint.new(:total_points => 'a').should have(2).error_on(:total_points)
    Sprint.new(:total_points => 1.35).should have(1).error_on(:total_points)
    Sprint.new(:total_points => 0).should have(1).error_on(:total_points)
    Sprint.new(:total_points => -2).should have(1).error_on(:total_points)
  end
  
  it "fails validation when name is not specified" do
    Sprint.new(:start_date => Date.new, :total_points => 25).should have(1).error_on(:name)
  end
  
  it "passes validation when name is specified" do
    Sprint.new(:start_date => Date.new, :total_points => 25, :name => 'nom').should have(0).error_on(:name)
  end
  
  
  it "fails validation when duration is not specified" do
    Sprint.new(:start_date => Date.new, :total_points => 25).should have(2).error_on(:duration)
  end
  
  it "passes validation when duration is specified" do
    Sprint.new(:start_date => Date.new, :total_points => 25, :duration => 10).should have(0).error_on(:duration)
  end
  
  it "should return the first element in days as the start date" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 5)
    sprint.days.first.should eq(sprint.start_date)
  end
  it "should return x day including start_date, where x is the duration specified" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 10)
    sprint.days.first.should eq(sprint.start_date)
    
    expected = (1..10).to_a.collect{ |x| sprint.start_date + (x - 1).day }
    
    sprint.days.should eq(expected)
  end
end