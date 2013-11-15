class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]
  

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

  def make_tags(app)
    categories = (File.read("Data/category.csv").strip) 
    key = ["category"]
    category_hash = CSV.parse(categories).map {|a| Hash[key.zip(a)]}
    words_array = app.description.split("\s") 
    tag_categories = []  
    category_hash.each do |category, subcategory|
      if words_array.include?(category)
        tag_categories << cateogry
        if words_array.include?(subcategory)
          tag_categories << subcategory
        end
      end
    end
    return app.tag_list = tag_categories
  end

  # POST /apps
  # POST /apps.json
  def create
    @app = App.new(app_params)    
    respond_to do |format|
      if @app.save
        make_tags(@app)
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
