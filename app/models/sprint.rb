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
  
  def points
    my_points = []
    duration.times { my_points << total_points }
    
    days.each_index do |i|
      current_day = days[i]
    
      current_points = progresses.select {|x| x.apply_date == current_day}
        .collect { |x| x.points }
        .sum
      
      last_index = my_points.size - 1
      i.upto(last_index) do |x|
        my_points[x] = (my_points[x] - current_points)
      end   
    end  
    
    max_index = days_progressed - 1
    my_points[0..max_index]
  end
  
  def days_progressed
    return 0 if progresses.size == 0
    days.index(progresses.last.apply_date) + 1
  end  
end
