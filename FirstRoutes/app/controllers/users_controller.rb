class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update

    begin
      user = User.find(params[:id])
    rescue StandardError => e
      render text: e, status: :not_found
      return
    end
    if params[:user]
      user.update(user_params)
      render json: user
    else
      render text: 'ERROR: User parameters must be specified', status: :unprocessable_entity
    end
  end

  def destroy
    begin
      user = User.find(params[:id])
    rescue StandardError => e
      render text: e, status: :not_found
      return
    end
    user.destroy
    render json: user
  end
end

private
def user_params
  params.require(:user).permit(:username)
end
