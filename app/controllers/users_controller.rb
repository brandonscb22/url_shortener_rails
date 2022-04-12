class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, only: [:show, :destroy]

  def show
    render json: @user, status: :ok
  end

  def update
    unless @user.update(user_params)
      render json: {errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.permit(:username, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
