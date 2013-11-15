class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]
  require 'csv'

  # GET /apps
  # GET /apps.json
  def index
    
    if params[:tag]
      @apps = App.tagged_with(params[:tag])
    else
      @apps = App.all
    end
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
    @apps = App.all
  end

  # GET /apps/new
  def new
    @app = App.new
  end

  # GET /apps/1/edit
  def edit
  end

  def get_category  
    # @category_hash = {}
    # CSV.foreach("Data/category.csv", :headers => true, :header_converters => :symbol, :converters => :all) do |row| 
    #   @category_hash[row.fields[0]] = Hash[row.headers[1..-1]]
      # @category_hash.each_key do |key|
        
      # end
    @category_hash = {"business" => 0, "communication" => 0, "productivity" => 0, "money & finance" => 0, "marketing" => 0, "social media" => 0, "music" => 0, "video" => 0, "photos" => 0, "graphics" => 0, "web design" => 0, "development" => 0, "working together" => 0, "travel" => 0, "lifestyle" => 0, "fun" => 0}
    
  end
    
    def make_tags(app)
    words_array = app.description.downcase.split("\s")
    @tag_categories = []    
     @category_hash.each_key do |key| 
      if words_array.include?(key)
      @tag_categories << key       
      end
     end
  end

  # POST /apps
  # POST /apps.json
  def create
    @app = App.new(app_params) 
    get_category
    make_tags(@app)
    @app.tag_list = @tag_categories
    respond_to do |format|
      if @app.save 
       
        format.html { redirect_to @app, notice: 'App was successfully created.' }
        format.json { render action: 'show', status: :created, location: @app }

      else
        format.html { render action: 'new' }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apps/1
  # PATCH/PUT /apps/1.json
  def update
    respond_to do |format|
      if @app.update(app_params)
        format.html { redirect_to @app, notice: 'App was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app.destroy
    respond_to do |format|
      format.html { redirect_to apps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.find(params[:id])      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:app).permit(:name, :description, :tag_list)
    end
end
