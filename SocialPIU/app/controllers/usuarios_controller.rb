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
    @user.Enable = false
    @user.Admi = false
    if @user.save
      redirect_to :controller => :start, :method => :index, :messeange => "Registrado, espere a que se un administrador le autorize su cuenta"
    else
      redirect_to :controller => :usuarios, :method => :new, :messeange => "Error al crear la cuenta, vuelva a intentarlo"
    end
  end

  def view
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @anti = @user.password
    if params[:newpassword]
      @user.password = params[:newpassword]
      @user.password_confirmation = params[:password_confirmation]
    end
    @user.email =  params[:email]
    @user.Type = params[:Type]
    @user.Name = params[:Name] 
    @user.LastName = params[:LastName]
    @user.Genre = params[:Genre]
    @user.Birthday = params[:Birthday]
    @user.Nickname = params[:Nickname]
    if(@anti == params[:oldpassword])
      @user.save 
      redirect_to :controller => :usuarios, :method => :view, :id => params[:id], :messeange => "Cuenta actualizada"
    else
      redirect_to "/usuarios/edit/"<< params[:id]
    end  
  end

  def controlusers
      @user = User.where(:Admi => false)
  end

  def activate
      @users = User.find(params[:id])
      @users.Enable = params[:enable]
      if @users.save
        if(params[:enable])
          redirect_to "/usuarios/controlusers", :messeange => "Usuario activado"
        else
          redirect_to "/usuarios/controlusers", :messeange => "Usuario desactivado"
        end
      else
        redirect_to "/usuarios/controlusers", :messeange => "Error al activar/desctivar usuario"
      end
  end

  def delete
      @users = User.find(params[:id])
      @users.destroy
      redirect_to "/usuarios/controlusers"
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :Type, :Enable, :Name, :LastName, :Genre, :Country, :City, :Birthday, :Nickname )
  end


end
