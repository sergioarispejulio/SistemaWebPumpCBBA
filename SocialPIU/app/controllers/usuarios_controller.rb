class UsuariosController < ApplicationController
  def new #Dirigue a la pantalla de crear usuario (get)
    if(current_user != nil)
      redirect_to root_url
    end
  end
  
  def create #Crea el usuario (post)
    @user = User.new
    @aux = params[:password].clone
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    @user.email =  params[:email]
    @user.Actucontrasena = encriptar(@aux)
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
      redirect_to signup_path
    end
  end

  def view #Muestra el usuario (get)
    @user = User.find(params[:id])
  end

  def edit #Dirigue a la pantalla de actualizar usuario (get)
    if(current_user == nil)
      redirect_to root_url
    else
      if(current_user.id != params[:id])
        if(current_user.Admi == false)
          redirect_to root_url
        end
      end
    end

    @user = User.find(params[:id])
  end

  def update #Actualiza el usuario (post)
    @user = User.find(params[:id])
    @anti = @user.Actucontrasena
    if (params[:newpassword].to_s.length != 0 && params[:newpassword] == params[:password_confirmation])
      puts params[:newpassword]
      @user.password = params[:newpassword]
      @user.password_confirmation = params[:password_confirmation]
      @aux = params[:newpassword].clone
      @user.Actucontrasena = encriptar(@aux)
    end
    @user.email =  params[:email]
    @user.Type = params[:Type]
    @user.Name = params[:Name] 
    @user.LastName = params[:LastName]
    @user.Genre = params[:Genre]
    @user.Birthday = params[:Birthday]
    @user.Nickname = params[:Nickname]

    if(params[:Admi].to_s == "true")

      if(params[:current].to_s == params[:id].to_s)
        if (@anti == encriptar(params[:oldpassword]) && params[:newpassword] == params[:password_confirmation])
          if @user.save
            Messenger.instance.obtenermensa("Cuenta actualizada por admi dando clasve") 
            redirect_to "/usuarios/view/"<<params[:id]
          else
            Messenger.instance.obtenermensa("Problemas al actualizar cuenta") 
            redirect_to "/usuarios/view/"<<params[:id]
          end
        else  
          Messenger.instance.obtenermensa("La contrasena antigua o la verificacion de la nueva contraseña no es valida") 
          redirect_to "/usuarios/edit/"<< params[:id]
        end
      else
        if@user.save
          Messenger.instance.obtenermensa("Cuenta actualizada") 
          redirect_to "/usuarios/view/"<<params[:id]
        else
          Messenger.instance.obtenermensa("Problemas al actualizar cuenta") 
          redirect_to "/usuarios/view/"<<params[:id]
        end
      end

    else
      if(@anti == encriptar(params[:oldpassword]) && params[:newpassword] == params[:password_confirmation]  )
        if @user.save
          Messenger.instance.obtenermensa("Cuenta actualizada") 
          redirect_to "/usuarios/view/"<<params[:id]
        else
          Messenger.instance.obtenermensa("Problemas al actualizar cuenta") 
          redirect_to "/usuarios/view/"<<params[:id]
        end
      else
        Messenger.instance.obtenermensa("La contrasena antigua o la verificacion de la nueva contraseña no es valida") 
        redirect_to "/usuarios/edit/"<< params[:id]
      end

    end  
  end

  def controlusers #Muestra la lista de todos los usuarios (get)
    if(current_user == nil)
      redirect_to root_url
    else
      if(current_user.Admi == false)
        redirect_to root_url
      end
    end
    @user = User.all
  end

  def activate #Activa/Desactiva un usuario (post)
      @users = User.find(params[:id])
      @users.Enable = params[:enable]
      if @users.save
        if(params[:enable] == "true".to_s)
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

  def delete #Elimina un usuario (post)
      @users = User.find(params[:id])
      @users.destroy
      Messenger.instance.obtenermensa("Usuario eliminado") 
      @events = Event.where(:iduser => params[:id])
      @events.each do |elemento|
        elemento.destroy
      end
      redirect_to "/usuarios/controlusers"
  end


  private

  def user_params
    params.require(:user).permit(:Actucontrasena ,:email, :password, :password_confirmation, :Type, :Enable, :Name, :LastName, :Genre, :Country, :City, :Birthday, :Nickname, :id, :Admi )
    params.require(:event).permit(:iduser)
  end

  def encriptar(elemento)
    messange = elemento<<elemento.reverse
    return messange.crypt("PUMPCBBA")
  end


end
