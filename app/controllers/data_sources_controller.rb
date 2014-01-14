class DataSourcesController < ApplicationController
  before_action :set_data_source, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /data_sources
  # GET /data_sources.json
  def index
    @data_sources = DataSource.where(:user => current_user)
  end

  # GET /data_sources/1
  # GET /data_sources/1.json
  def show
    # binding.pry
  end

  # GET /data_sources/new
  def new
    @data_source = DataSource.new
  end

  # GET /data_sources/1/edit
  def edit
  end

  # POST /data_sources
  # POST /data_sources.json
  def create
    @data_source = DataSource.new(data_source_params)
    @data_source.user = current_user
    @data_source.status = "uploaded"

    respond_to do |format|
      if @data_source.save
        Resque.enqueue(DownloadDataSourceJob, @data_source.id)
        format.html { redirect_to @data_source, notice: 'Data source was successfully created.' }
        format.json { render action: 'show', status: :created, location: @data_source }
      else
        format.html { render action: 'new' }
        format.json { render json: @data_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data_sources/1
  # PATCH/PUT /data_sources/1.json
  def update
    respond_to do |format|
      if @data_source.update(data_source_params)
        Resque.enqueue(DownloadDataSourceJob, @data_source.id) if data_source_params.include? :data_file
        format.html { redirect_to @data_source, notice: 'Data source was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @data_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_sources/1
  # DELETE /data_sources/1.json
  def destroy
    @data_source.destroy
    respond_to do |format|
      format.html { redirect_to data_sources_url }
      format.json { head :no_content }
    end
  end

  def serve_data_file
    content = @data_source.data_file
    if stale?(etag: content, last_modified: @data_file.updated_at.utc, public: true)
      send_data content, type: @data_file.data_file.file.content_type, disposition: "inline"
      expires_in 0, public: true
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_source
      @data_source = DataSource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_source_params
      params[:data_source].permit(:name, :image, :data_file)
    end
end
