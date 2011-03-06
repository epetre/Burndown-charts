class SprintProgressValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if object.respond_to?('progresses')
      sprint = object
      progresses = object.progresses.to_a
    elsif(object.respond_to?('sprint') && object.sprint.respond_to?('progresses'))
      sprint = object.sprint
      progresses = object.sprint.progresses.to_a
    else
      return
    end
    
    validate_progresses(sprint, progresses) do
      object.errors[attribute] << (options[:message] || error_message)
    end
  end
  
  def validate_progresses(sprint, progresses)
    raise 'method not implemented'
  end  
  def error_message
    raise 'method not implemented'
  end
end