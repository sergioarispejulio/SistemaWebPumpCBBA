class EventosController < ApplicationController

	def new
		controllogin()
	end

	def create
		controuser(params[:Iduse])
		@evento = Event.new
		@evento.description = params[:Description]
		@evento.tipo = params[:tipo]
		@evento.direction= params[:Direction]
		@evento.name = params[:Name]
		@evento.iduser = params[:Iduse]
		if(current_user.Admi == true)
			@evento.enable = true
		else
			@evento.enable = false
		end
		@evento.date_create = params[:Fecha]
		@evento.date_modify = params[:Fecha]
		if @evento.save
			if(current_user.Admi == true)
				Messenger.instance.obtenermensa("Evento creado") 
				redirect_to :controller => :start, :method => :index
			else
				Messenger.instance.obtenermensa("Evento creado, esperar hasta que un administrador valide el evento") 
				redirect_to :controller => :start, :method => :index
			end
    	else
    		Messenger.instance.obtenermensa("Error al crear el evento, vuelva a intentarlo") 
    		redirect_to :controller => :eventos, :method => :new
  		end
	end

	def delete
		controadmi()
		@evento = Event.find(params[:id])
      	@evento.destroy
      	Messenger.instance.obtenermensa("Evento eliminado") 
      	redirect_to "/event/viewnotaceptedevents"
	end

	def edit
		@evento = Event.find(params[:id])
		controuser(@evento.iduser)
	end

	def update
		controuser(params[:Iduse])
		@evento = Event.find(params[:id])
		@evento.description = params[:Description]
		@evento.tipo = params[:tipo]
		@evento.direction= params[:Direction]
		@evento.name = params[:Name]
		@evento.iduser = params[:Iduse]
		@evento.date_modify = params[:Fecha]
		if @evento.save
			Messenger.instance.obtenermensa("Evento editado") 
    		redirect_to "/event/"+params[:id]
    	else
    		Messenger.instance.obtenermensa("Error al editar evento, vuelva a intentarlo") 
    		redirect_to :controller => :eventos, :method => :edit, :id => params[:id]
  		end
	end

	def accept
		controadmi()
		@evento = Event.find(params[:id])
      	@evento.enable = true
      	if @evento.save
      		Messenger.instance.obtenermensa("Evento aceptado") 
    		redirect_to "/event/viewnotaceptedevents"
    	else
    		Messenger.instance.obtenermensa("Error al aceptar evento") 
    		redirect_to "/event/viewnotaceptedevents"
  		end
	end

	def view
		@evento = Event.find(params[:id])
	end

	def viewnotaceptedevents
		controadmi()
		@evento = Event.where(:enable => false)
	end

	private

	def user_params
    	params.require(:event).permit(:description, :direction, :enable, :iduser, :name, :tipo, :date_modify, :date_create)
    	params.require(:user).permit(:Name, :LastName, :Admi)
  	end

  	def controllogin()
  		if(current_user== nil)
  			root_path
  		end
  	end

  	def controuser(identi)
  		if(current_user== nil || current_user.id != identi)
  			root_path
  		end
  	end

  	def controadmi()
  		if(current_user == nil || current_user.Admi == false)
  			root_path
  		end
  	end

end
