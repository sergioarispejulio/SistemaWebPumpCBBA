class UsuariosController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    @user.email =  params[:email]
    @user.Type = params[:Type]
    @user.Name = params[:Name] 
    @user.LastName = params[:LastName]
    @user.Genre = params[:Genre]
    @user.Country = params[:Country] 
    @user.City = params[:City] 
    @user.Birthday = params[:Birthday]
    @user.Nickname = params[:Nickname]
    @user.Enable = params[:Enable]
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :Type, :Enable, :Name, :LastName, :Genre, :Country, :City, :Birthday, :Nickname )
  end


end
