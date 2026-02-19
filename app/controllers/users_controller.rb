class UsersController < ApplicationController
  #GET /users/:id
  def show
    @user = User.find(params[:id])
    if params[:id] != @user.to_param
      redirect_to @user, status: :moved_permanently
    end
  end
end