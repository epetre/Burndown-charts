require 'spec_helper'

describe Sprint do
  it "correlated points should use the max as the first point" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 5, :total_points => 25)
    
    sprint.progresses << Progress.new(:points => 13, :apply_date => sprint.start_date)
    sprint.progresses << Progress.new(:points => 5, :apply_date => sprint.start_date + 1.day)
    
    sprint.correlated_points.should eq([16, 7])
  end
  
  it "should should return corrlated points using min and max of points and completing the graph till the last day" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 5, :total_points => 50)
    
    sprint.progresses << Progress.new(:points => 5, :apply_date => sprint.start_date)
    sprint.progresses << Progress.new(:points => 5, :apply_date => sprint.start_date + 1.days)
    
    sprint.correlated_points.should eq([45, 40, 35, 30, 25])
  end
  it "should always return correlated points with a length equal to the duration" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 5, :total_points => 50)
    
   
    sprint.correlated_points.size.should eq(sprint.duration)
  end
  
  it "fails validation when apply_date in progresses are not in the sprint timespan" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 3, :total_points => 15)
    sprint.progresses << Progress.new(:points => 5, :apply_date => Date.new + 5.days)
    
    sprint.should have(1).error_on(:start_date)
    sprint.should have(1).error_on(:duration)
  end
  it "fails validation when progresses points are higher than total points" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 3, :total_points => 10)
    sprint.progresses << Progress.new(:points => 5, :apply_date => sprint.days.first, :sprint => sprint)
    sprint.progresses << Progress.new(:points => 5, :apply_date => sprint.days[1], :sprint => sprint)
    sprint.progresses << Progress.new(:points => 5, :apply_date => sprint.days.last, :sprint => sprint)
    
    sprint.should have(1).error_on(:total_points)
  end
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
    Sprint.new(:total_points => -2).should have(2).error_on(:total_points)
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
  
  it "should return total points for each day when no progress is made" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 5, :total_points => 100)
   
    sprint.points.should eq([100, 100, 100, 100, 100])
  end
  
  it "should return total points less progress when the progress is made on the first day" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 5, :total_points => 100)
    
    sprint.progresses << Progress.new(:points => 10, :apply_date => sprint.days.first)
    sprint.points.should eq([90])
  end
  
 it "should return total points less progress points for each progresses" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 5, :total_points => 100)
    
    sprint.progresses << Progress.new(:points => 15, :apply_date => sprint.days.first)
    sprint.progresses << Progress.new(:points => 5, :apply_date => sprint.days[1])
    sprint.progresses << Progress.new(:points => 10, :apply_date => sprint.days[2])
    sprint.progresses << Progress.new(:points => 70, :apply_date => sprint.days.last)
    
    sprint.points.should eq([85, 80, 70, 70, 0])
  end
  
  it "should never return an array bigger than days_progressed" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 5, :total_points => 100)
    
    sprint.progresses << Progress.new(:points => 15, :apply_date => sprint.days.first)
    sprint.progresses << Progress.new(:points => 5, :apply_date => sprint.days[1])
    
    sprint.points.should eq([85, 80])
  end

  it "should return days_progression equal to 0 if there is no progress in the sprint" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 5, :total_points => 100)
    
    sprint.days_progressed.should eq(0)
  end
  it "should return the sprint duration when there is a progression with an apply_date equal to the last progression day" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 5, :total_points => 100)
    sprint.progresses << Progress.new(:points => 70, :apply_date => sprint.days.last)
    
    sprint.days_progressed.should eq(sprint.duration)
  end
  it "should return the index of days that equals the latest apply_date of progression" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 5, :total_points => 100)
    
    sprint.progresses << Progress.new(:points => 5, :apply_date => sprint.days.first)
    sprint.progresses << Progress.new(:points => 70, :apply_date => sprint.days[2])
    
    sprint.days_progressed.should eq(3)
  end
end
