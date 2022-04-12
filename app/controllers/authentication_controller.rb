class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'unauthorized'}, status: :unauthorized
    end
  end
  # POST /auth/sign_up
  def sign_up
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: {errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.permit(:username, :email, :password)
    end
end
