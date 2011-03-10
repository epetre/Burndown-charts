require 'MaximumPointsValidator'
require 'SprintDaysValidator'

class Sprint < ActiveRecord::Base
  has_many :progresses, :autosave => false
  include ActiveModel::Validations
  
  validates :name, :presence => true
  validates :start_date, :presence => true , :sprint_days => true
  
  validates :duration, :presence => true, :sprint_days => true
  validates_numericality_of :duration, :only_integer => true, :message => "can only be whole number."
  
  validates_numericality_of :total_points, :only_integer => true, :message => "can only be whole number."
  validates :total_points, :presence => true, :maximum_points => true
  validates_inclusion_of :total_points, :in => 1..1000, :message => "can only be between 1 and 1000." 
  
  validates_associated :progresses
  def days
    if start_date.nil? || duration.nil?
      return []  
    end  
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
    return 0 if progresses.empty?
    (days.index(progresses.last.apply_date) || -1) + 1
  end  

  def correlated_points
    ratio = (total_points - points.last) / (points.size || 1)
    
    current_points = []
    duration.times do
      new_points = (current_points.last || total_points) - ratio
      current_points << new_points if new_points >= 0
    end
    current_points
  end  
end
