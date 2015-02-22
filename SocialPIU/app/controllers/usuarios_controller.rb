class UsuariosController < ApplicationController
  def new
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
      Messenger.instance.obtenermensa("Registrado, espere a que se un administrador le autorize su cuenta")
      redirect_to :controller => :start, :method => :index
    else
      Messenger.instance.obtenermensa("Error al crear la cuenta, vuelva a intentarlo")
      redirect_to :controller => :usuarios, :method => :new
    end
  end

  def view
    @user = User.find(params[:id])
  end

  def edit
    controuser(params[:id])
    @user = User.find(params[:id])
  end

  def update
    controuser(params[:id])
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
      Messenger.instance.obtenermensa("Cuenta actualizada") 
      redirect_to :controller => :usuarios, :method => :view, :id => params[:id]
    else
      redirect_to "/usuarios/edit/"<< params[:id]
    end  
  end

  def controlusers
      controadmi()
      @user = User.where(:Admi => false)
  end

  def activate
      controadmi()
      @users = User.find(params[:id])
      @users.Enable = params[:enable]
      if @users.save
        if(params[:enable] == true)
            Messenger.instance.obtenermensa("Usuario activado") 
          else
            Messenger.instance.obtenermensa("Usuario desactivado") 
          end
          redirect_to "/usuarios/controlusers" 
        else
          Messenger.instance.obtenermensa("Problemas al activar/desactivar") 
          redirect_to "/usuarios/controlusers" 
      end
  end

  def delete
      controadmi()
      @users = User.find(params[:id])
      @users.destroy
      Messenger.instance.obtenermensa("Usuario eliminado") 
      redirect_to "/usuarios/controlusers"
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :Type, :Enable, :Name, :LastName, :Genre, :Country, :City, :Birthday, :Nickname )
  end

  def controuser(identi)
    if(current_user== nil || current_user.id != identi)
      redirect_to root_path
    end
  end

  def controadmi()
    if(current_user == nil || current_user.Admi == false)
      redirect_to root_path
    end
  end


end
