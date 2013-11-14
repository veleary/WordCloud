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

  # POST /apps
  # POST /apps.json
  def create
    @app = App.new(app_params)
    @app.tag_list = @app.description
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

    # def make_tags
    #   App.all.each do |app| 
    #     words = app.description.split("\s")
    #     # counts = Hash.new(0)
    #     # words.each do |w|
    #     #   counts[w] += 1
    #     # end
    #     tag_list = []
    #     # sorted_tag_list = counts.to_a.sort_by do |word, count|
    #     #   -count
    #       tag_list << words
    #     # end
    #    tag_list = app.tag_list.join(", ")  
    #    # tag_list.html_safe  
    #   end
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:app).permit(:name, :description, :tag_list)
    end
end
