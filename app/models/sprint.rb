class Sprint < ActiveRecord::Base
  has_many :progresses
  
  validates :start_date, :presence => true 
  validates :total_points, :presence => true
  validates_numericality_of :total_points, :only_integer => true, :message => "can only be whole number."
  validates_inclusion_of :total_points, :in => 1..1000, :message => "can only be between 1 and 1000." 
  
  def days
    return [start_date]
  end
end
