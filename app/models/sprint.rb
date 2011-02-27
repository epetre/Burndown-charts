class Sprint < ActiveRecord::Base
  has_many :progresses
  
  validates :name, :presence => true
  validates :start_date, :presence => true 
  validates :total_points, :presence => true
  validates :duration, :presence => true 
  
  validates_numericality_of :total_points, :only_integer => true, :message => "can only be whole number."
  validates_numericality_of :duration, :only_integer => true, :message => "can only be whole number."
  validates_inclusion_of :total_points, :in => 1..1000, :message => "can only be between 1 and 1000." 
  
  def days
    (1..duration).to_a.collect{ |x| start_date + (x - 1).day }
  end
end
