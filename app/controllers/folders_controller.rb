class FoldersController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  # GET /folders
  # GET /folders.xml
  def index
    @folders = Folder.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @folders }
      format.json  { render :json => @folders }
    end
  end

  # GET /folders/1
  # GET /folders/1.xml
  def show
    @folder = Folder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @folder }
      format.json  { render :json => @folder }
    end
  end

  # GET /folders/new
  # GET /folders/new.xml
  def new
    @folder = Folder.new
    @parent_id = params[:folder_id].to_i
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @folder }
      format.json  { render :json => @folder }
    end
  end

  # GET /folders/1/edit
  def edit
    @folder = Folder.find(params[:id])
  end

  # POST /folders
  # POST /folders.xml
  def create
    @folder = Folder.new(params[:folder])

    @folder.user = current_user

    if params[:folder][:folder_id] == "0"
      @folder.folder = nil
    end    

    respond_to do |format|
      if @folder.save
        format.html { redirect_to(@folder, :notice => 'Folder was successfully created.') }
        format.xml  { render :xml => @folder, :status => :created, :location => @folder }
        format.json  { render :json => @folder, :status => :created, :location => @folder }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @folder.errors, :status => :unprocessable_entity }
        format.json  { render :json => @folder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /folders/1
  # PUT /folders/1.xml
  def update
    @folder = Folder.find(params[:id])

    respond_to do |format|
      if @folder.update_attributes(params[:folder])
        format.html { redirect_to(@folder, :notice => 'Folder was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @folder.errors, :status => :unprocessable_entity }
        format.json  { render :json => @folder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.xml
  def destroy
    @folder = Folder.find(params[:id])
    @folder.destroy

    respond_to do |format|
      format.html { redirect_to(folders_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
end
