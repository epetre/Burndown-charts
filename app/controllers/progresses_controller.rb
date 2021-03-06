class ProgressesController < ApplicationController
  # GET /progresses
  # GET /progresses.xml
  def index
    @sprint = Sprint.find(params[:sprint_id])
    @progresses = Progress.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @progresses }
    end
  end

  # GET /progresses/1
  # GET /progresses/1.xml
  def show
    @sprint = Sprint.find(params[:sprint_id])
    @progress = Progress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @progress }
    end
  end

  # GET /progresses/new
  # GET /progresses/new.xml
  def new
    @sprint = Sprint.find(params[:sprint_id])
    @progress = Progress.new()
    @error_messages = []
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @progress }
    end
  end

  # GET /progresses/1/edit
  def edit
    @sprint = Sprint.find(params[:sprint_id])
    @progress = Progress.find(params[:id])
    @error_messages = []
  end

  # POST /progresses
  # POST /progresses.xml
  def create
    @sprint = Sprint.find(params[:sprint_id])
    @progress = @sprint.progresses.build(params[:progress])
    
    respond_to do |format|
      if @sprint.save && @progress.save
        format.html { redirect_to( :url => sprint_progress_path(@sprint, @progress), :notice => 'Progress was successfully created.') }
        format.xml  { render :xml => [@sprint, @progress], :status => :created, :location => @progress }
      else
        @error_messages = @sprint.errors.full_messages.concat(@progress.errors.full_messages)
        format.html { render :action => :new }
        format.xml  { render :xml => @sprint.errors.concat(@progress.errors), :status => :unprocessable_entity }
      end
    end
  end

  # PUT /progresses/1
  # PUT /progresses/1.xml
  def update
    @sprint = Sprint.find(params[:sprint_id])
    @progress = Progress.find(params[:id])

    respond_to do |format|
      if @progress.update_attributes(params[:progress])
        format.html { redirect_to(:url => sprint_progress_path(@sprint, @progress), :notice => 'Progress was successfully updated.') }
        format.xml  { head :ok }
      else
        @error_messages = @sprint.errors.full_messages.concat(@progress.errors.full_messages)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @progress.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /progresses/1
  # DELETE /progresses/1.xml
  def destroy
    @sprint = Sprint.find(params[:sprint_id])
    @progress = Progress.find(params[:id])
    @progress.destroy

    respond_to do |format|
      format.html { redirect_to([@sprint, @progress]) }
      format.xml  { head :ok }
    end
  end
end
