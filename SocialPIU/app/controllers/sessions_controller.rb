class SessionsController < ApplicationController
  def new #Va a la ventana de login
  end
  
  def create #Inicia el login y verificacion de este (get)
    user = login(params[:email], params[:password], params[:remember_me])
    if user 
      if(current_user.Enable)
        redirect_back_or_to root_url
      else
        logout
        Messenger.instance.obtenermensa("Su cuenta no a sido validada aun") 
        redirect_to login_path
      end
    else
      Messenger.instance.obtenermensa("Error al iniciar seccion, vuelva a intentarlo") 
      redirect_to login_path
    end
  end

  def destroy #Cierra seccion
  	logout
  	redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :Type, :Enable, :Name, :LastName, :Genre, :Country, :City, :Birthday, :Nickname )
  end

end
