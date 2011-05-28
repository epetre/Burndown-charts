class AuthenticationsController < ApplicationController
  # GET /authentications
  # GET /authentications.xml
  def index
    @authentications = Authentication.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @authentications }
    end
  end

  # GET /authentications/1
  # GET /authentications/1.xml
  def show
    @authentication = Authentication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @authentication }
    end
  end

  # GET /authentications/new
  # GET /authentications/new.xml
  def new
    @authentication = Authentication.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @authentication }
    end
  end

  # GET /authentications/1/edit
  def edit
    @authentication = Authentication.find(params[:id])
  end

  # POST /authentications
  # POST /authentications.xml
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in succesfuly"
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication succesful"
      redirect_to authentications_url
    else 
        user = User.new
        user.apply_omniauth(omniauth)
        
        if user.save
          flash[:notice] = "Signed in succesfuly"
          sign_in_and_redirect(:user, authentication.user)
        else
          session[:omniauth] = omniauth.except('extra')
          redirect_to new_user_registration_url
        end
    end
  end

  # PUT /authentications/1
  # PUT /authentications/1.xml
  def update
    @authentication = Authentication.find(params[:id])

    respond_to do |format|
      if @authentication.update_attributes(params[:authentication])
        format.html { redirect_to(@authentication, :notice => 'Authentication was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @authentication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /authentications/1
  # DELETE /authentications/1.xml
  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy

    respond_to do |format|
      format.html { redirect_to(authentications_url) }
      format.xml  { head :ok }
    end
  end
end
