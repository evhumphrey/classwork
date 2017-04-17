class UsersController < ApplicationController
  def index
    render text: 'I like propane and propane accessories'
  end

  def create
    render json: params
  end

  def show
    render json: params
  end
end
