require 'SprintProgressValidator'
class MaximumPointsValidator < SprintProgressValidator
  def validate_progresses(sprint, progresses)
    Rails.logger.info " --- > TRIED TO VALIDATE"
    if progresses.nil? || !progresses.respond_to?('to_a') || !sprint.respond_to?('total_points')
      Rails.logger.info " --- > SOMETHING WAS WRONG"
      return
    end 
    progresses_points = progresses.sum{|x| x.points }
    
    Rails.logger.info " progresses_points > (sprint.total_points || 0) ? #{progresses_points > (sprint.total_points || 0)}"
    if progresses_points > (sprint.total_points || 0)
      yield
    end
  end
  def error_message
    "Too many points are specified in last progress."
  end
end