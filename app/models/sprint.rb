class Sprint < ActiveRecord::Base
  has_many :progresses
  
  def days
    return '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]'
  end
end
