require 'spec_helper'

describe Progress do
  it "fails validation with no apply_date (using error_on)" do
    Progress.new.should have(1).error_on(:apply_date)
  end

  it "fails validation with no points (using error_on)" do
    Progress.new.should have(3).error_on(:points)
  end
  
  it "fails validation with non integer points (using error_on)" do
    Progress.new(:points => 'a').should have(2).error_on(:points)
    Progress.new(:points => 1.5).should have(1).error_on(:points)
  end
  
  it "fails validation with non positive points (using error_on)" do
    Progress.new(:points => -5).should have(1).error_on(:points)
  end
  
  it "passes validation with positive points (using error_on)" do
    Progress.new(:points => 12).should have(0).error_on(:points)
  end
  
  it "fails validation when sum of points is higher than the sprint total points" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 3, :total_points => 10)
    sprint.progresses << Progress.new(:points => 5, :apply_date => sprint.days.first, :sprint => sprint)
    sprint.progresses << Progress.new(:points => 5, :apply_date => sprint.days[1], :sprint => sprint)
    last_progress = Progress.new(:points => 5, :apply_date => sprint.days.last, :sprint => sprint)
    sprint.progresses << last_progress
    
    last_progress.should have(1).error_on(:points)
  end
  
  it "fails validation when apply_date is not part of sprint time span" do
    sprint = Sprint.new(:start_date => Date.new, :duration => 3, :total_points => 10)
    sprint.progresses << Progress.new(:points => 5, :apply_date => sprint.days.last + 1.day, :sprint => sprint)
    
    sprint.progresses.last.should have(1).error_on(:apply_date)
  end
end