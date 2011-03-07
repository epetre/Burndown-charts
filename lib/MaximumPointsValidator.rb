require 'SprintProgressValidator'
class MaximumPointsValidator < SprintProgressValidator
  def validate_progresses(sprint, progresses)
    if progresses.nil? || !progresses.respond_to?('to_a') || !sprint.respond_to?('total_points')
      return
    end 
    progresses_points = progresses.sum{|x| x.points }
    
    if progresses_points > (sprint.total_points || 0)
      yield
    end
  end
  def error_message
    "Too many points are specified in last progress."
  end
end