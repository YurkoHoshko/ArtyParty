class Api::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_user!, only: :index


  def next_birthday
    @user = User.upcoming
    render json: @user
  end

  def check_user
    render json: {user: current_user} if current_user
    render json: 'You should sign in or sign up before continuing', status: 403 unless current_user
  end

  def index
    @users = User.sorted
    render json: @users
  end
end