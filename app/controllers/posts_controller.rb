class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  include Geokit::Geocoders
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    # // why is this required for user validation? -- Rails 5 requirements (search - "rails user must exist belongs to")
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)


        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # def geocode_address
    #   geo=Geokit::Geocoders::GoogleGeocoder.geocode(address)
    #   errors.add(:address, "Could not Geocode address") if !geo.success
    #   self.lat, self.lng = geo.lat,geo.lng if geo.success
    # end
    # def geocode_address
    #   if !address_geo.blank?
    #     geo=Geokit::Geocoders::MultiGeocoder.geocode(address_geo)
    #     errors.add(:address, "Could not Geocode address") if !geo.success
    #     self.lat, self.lng = geo.lat,geo.lng if geo.success
    #   end
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      # params.fetch(:post {:title, :item, :description})
      params.require(:post).permit(:title, :item, :description, :user_id, :image, :lat, :lng, :address, :latitude, :longitude)
    end
end
