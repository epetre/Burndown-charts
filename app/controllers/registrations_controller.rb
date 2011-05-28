class RegistrationsController < Devise::RegistrationsController
  def create
    super 
    session[:omniauth] = nil unless @user.new_record?
    logger.info 'was in create !!!!!!!!!!!!!!!!!!!!!'
  end
  def build_resource(*args)
    super 
    logger.info 'was in buildresource !!!!!!!!!!!!!!!!!!!!!'
    if session[:omniauth]
      logger.info 'ominiauth is in session !!!!!!!!!!!!!!!!!!!!!'
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
end
