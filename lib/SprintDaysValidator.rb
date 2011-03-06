require 'SprintProgressValidator'
class SprintDaysValidator < SprintProgressValidator
  def validate_progresses(sprint, progresses)
    if progresses.nil? || !progresses.respond_to?('to_a') || !sprint.respond_to?('days')
      return
    end 
    yield unless progresses.select{|x| !sprint.days.include?(x.apply_date) }.empty? 
  end
  
  def error_message
    "Progress apply date is not part of the current sprint time span"
  end
end