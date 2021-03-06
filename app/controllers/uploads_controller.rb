class UploadsController < ApplicationController
  before_filter :login_required, :except => [:file, :index, :edit, :update]

  def file
    @upload = Upload.find(params[:id])

    unless @upload.locked?
      send_file @upload.file.path, :type => @upload.file_content_type, :disposition => 'inline'
      @upload.download_count+=1
      @upload.save!
    else
      flash[:error]="This file is locked."

      redirect_to(:controller=>"uploads")
    end
  end

  def lock
    set_locked(params[:id], true)

    redirect_to(:controller=>"uploads")
  end

  def unlock
    set_locked(params[:id], false)

    redirect_to(:controller=>"uploads")
  end

  def guest_upload
    @upload=Upload.new
    @upload.download_count=0
    
    @upload.user=current_user
    @upload.save!
  end

  # GET /uploads
  # GET /uploads.xml
  def index
    @uploads = Upload.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @uploads }
      format.json { render :json => @uploads }
    end
  end

  # GET /uploads/new
  # GET /uploads/new.xml
  def new
    @upload = Upload.new
    @upload.upload_type= :normal
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @upload }
      format.json { render :json => @upload }
    end
  end

  # GET /uploads/1/edit
  def edit
    if params[:id]
      login_required
      @upload=Upload.find(params[:id])
    else
      @upload=Upload.find_by_guest_token(params[:guest_token])

      if @upload.file.exists?
        flash[:error]='File was already uploaded.'
        redirect_to :controller=>"uploads"
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @upload }
      format.json { render :json => @upload }
    end
  end

  # GET /uploads/1
  # GET /uploads/1.xml
  def show
    @upload = Upload.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @upload }
      format.json  { render :json => @upload }
    end
  end

  # POST /uploads
  # POST /uploads.xml
  def create
    @upload = Upload.new(params[:upload])
    @upload.download_count=0
    @upload.user=current_user

    if @upload.upload_type.eql? "guest"
      @upload.guest_token=Upload.unique_id

      description =params[:upload][:description]

      if description.empty?
        @upload.description="Guest upload opened by "+@upload.user.login
      else
        @upload.description=description
      end
    end

    respond_to do |format|
      if @upload.save
        flash[:notice]='Upload was successfully created.'

        if @upload.upload_type.eql? "guest"
          format.html { redirect_to(upload_path @upload) }
        else
          format.html { redirect_to(:controller=>"uploads") }
        end
        
        format.xml  { render :xml => @upload, :status => :created, :location => @upload }
        format.json  { render :json => @upload, :status => :created, :location => @upload }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
        format.json  { render :json => @upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.xml
  def update
    @upload = Upload.find(params[:id])

    flash[:notice]='Upload was successfully updated.'

    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        format.html { 
          if @upload.folder
            redirect_to(@upload.folder)
          else
            redirect_to(:controller=>"uploads")
          end
        }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
        format.json  { render :json => @upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.xml
  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to(:controller=>"uploads") }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end

  private

  def set_locked(upload_id, locked)
    @upload = Upload.find(upload_id)
    @upload.locked=locked
    @upload.save!
  end

end
