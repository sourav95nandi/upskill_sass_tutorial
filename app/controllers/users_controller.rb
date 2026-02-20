class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  #GET /users
  def index
    @users = User.all
  end
  
  #GET /users/:id
  def show
    @user = User.find(params[:id])
    if params[:id] != @user.to_param
      redirect_to @user, status: :moved_permanently
    end
  end
end