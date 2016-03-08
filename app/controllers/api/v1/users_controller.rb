require 'pry'

class Api::V1::UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]

  skip_before_filter :authenticate_user_from_token, :only => [:create]
  skip_before_filter :check_self_user_from_token, :only => [:create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      # render json: @user, status: :created, location: @user
      render json: { token: @user.api_token }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    binding.pry
    @user.destroy

    head :no_content
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params

      params.permit(:email, :city, :cp, :password)
    end
end
