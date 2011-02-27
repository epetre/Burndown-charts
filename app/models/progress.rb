class Progress < ActiveRecord::Base
  belongs_to :sprint
  
  validates :apply_date, :presence => true
  validates :points, :presence => true
  validates_numericality_of :points, :only_integer => true, :message => "can only be whole number."
  validates_inclusion_of :points, :in => 1..1000, :message => "can only be positive." 
end
