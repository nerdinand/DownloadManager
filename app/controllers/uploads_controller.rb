class UploadsController < ApplicationController
  before_filter :login_required, :except => [:file, :index]

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

  # GET /uploads
  # GET /uploads.xml
  def index
    @uploads = Upload.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @uploads }
    end
  end

  # GET /uploads/new
  # GET /uploads/new.xml
  def new
    @upload = Upload.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @upload }
    end
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
  end

  # POST /uploads
  # POST /uploads.xml
  def create
    @upload = Upload.new(params[:upload])

    flash[:notice]='Upload was successfully created.'

    respond_to do |format|
      if @upload.save
        format.html { redirect_to(:controller=>"uploads") }
        format.xml  { render :xml => @upload, :status => :created, :location => @upload }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
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
        format.html { redirect_to(:controller=>"uploads") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
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
    end
  end

  private

  def set_locked(upload_id, locked)
    @upload = Upload.find(upload_id)
    @upload.locked=locked
    @upload.save!
  end

end
