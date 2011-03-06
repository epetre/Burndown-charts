require 'MaximumPointsValidator'
require 'SprintDaysValidator'

class Progress < ActiveRecord::Base
  belongs_to :sprint
  include ActiveModel::Validations
  
  scope :applied_on, (lambda do |date| {:conditions => ['apply_date = ?', title]} end)
    
  validates :apply_date, :presence => true, :sprint_days => true
  validates :points, :presence => true, :maximum_points => true
  validates_numericality_of :points, :only_integer => true, :message => "can only be whole number."
  validates_inclusion_of :points, :in => 1..1000, :message => "can only be positive." 
end
