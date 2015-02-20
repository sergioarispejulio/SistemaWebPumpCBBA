class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user 
      if(current_user.Enable)
        redirect_back_or_to root_url
      else
        logout
        redirect_to login_path, :messeange => "Su cuenta no a sido validada aun"
      end
    else
      redirect_to login_path, :messeange=> "Error al iniciar seccion, vuelva a intentarlo"
    end
  end

  def destroy
  	logout
  	redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :Type, :Enable, :Name, :LastName, :Genre, :Country, :City, :Birthday, :Nickname )
  end

end
