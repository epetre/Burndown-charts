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
end