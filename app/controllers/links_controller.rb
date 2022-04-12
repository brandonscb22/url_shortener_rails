class LinksController < ApplicationController
  before_action :set_link, only: %i[ show update destroy ]

  # GET /links
  def index
    @links = Link.where(user_id: @current_user.id)
    render json: @links
  end

  # GET /links/1
  def show
    render json: @link
  end

  # POST /links
  def create
    puts link_params.merge(url_generated: generate_link)
    @link = Link.create(link_params.merge(url_generated: generate_link, user_id: @current_user.id))
    if @link.save
      render json: {url_generated: ("%{BASE_URL}/"  + @link.url_generated) % ENV.to_h.symbolize_keys }, status: :created, location: @link
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /links/1
  def update
    if @link.update(link_params)
      render json: @link
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /links/1
  def destroy
    @link.destroy
  end

  private

    def set_link
      @link = Link.find_by(id: params[:id], user_id: @current_user.id)
    end

    def link_params
      params.require(:link).permit(:url, :url_generated)
    end
    def generate_link
      DateTime.now.hash.abs.to_s(36)
    end
end
