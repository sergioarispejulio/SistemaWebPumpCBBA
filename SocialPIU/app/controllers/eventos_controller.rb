class EventosController < ApplicationController

	def new #Va a la pantalla para crear eventos (get)
		if(current_user == nil)
			redirect_to root_url
		end
	end

	def create #Crea un evento (post)
		@evento = Event.new
		@evento.description = params[:Description]
		@evento.tipo = params[:tipo]
		@evento.direction= params[:Direction]
		@evento.name = params[:Name]
		@evento.iduser = params[:Iduse]
		if(params[:Enable] == "true".to_s)
			@evento.enable = true
		else
			@evento.enable = false
		end
		@evento.date_create = params[:Fecha]
		@evento.date_modify = params[:Fecha]
		if @evento.save
			if(params[:Enable] == "true")
				Messenger.instance.obtenermensa("Evento creado") 
			else
				Messenger.instance.obtenermensa("Evento creado, esperar hasta que un administrador valide el evento") 
			end
			redirect_to :controller => :start, :method => :in
    	else
    		Messenger.instance.obtenermensa("Error al crear el evento, vuelva a intentarlo") 
    		redirect_to :controller => :eventos, :method => :new
  		end
	end

	def delete #Elimina un evento (post)
		@evento = Event.find(params[:id])
      	@evento.destroy
      	Messenger.instance.obtenermensa("Evento eliminado") 
      	redirect_to "/event/viewnotaceptedevents"
	end

	def edit #Va a la pantalla de editar evento (get)
		@evento = Event.find(params[:id])
		if(current_user == nil)
			redirect_to root_url
		else
			if(current_user.Admi == false || current_user.id != @evento.Iduse)
				redirect_to root_url
			end
		end
	end

	def update #Actualiza un evento (post)
		@evento = Event.find(params[:id])
		@evento.description = params[:Description]
		@evento.tipo = params[:tipo]
		@evento.direction= params[:Direction]
		@evento.name = params[:Name]
		@evento.date_modify = params[:Fecha]
		if @evento.save
			Messenger.instance.obtenermensa("Evento editado") 
    		redirect_to "/event/"+params[:id]
    	else
    		Messenger.instance.obtenermensa("Error al editar evento, vuelva a intentarlo") 
    		redirect_to :controller => :eventos, :method => :edit, :id => params[:id]
  		end
	end

	def activate #Activa/Desactiva un evento (post)
		@evento = Event.find(params[:id])
      	@evento.enable = params[:enable]
      	if @evento.save
      		if(params[:enable] == "true")
      			Messenger.instance.obtenermensa("Evento habilitado") 
      		else
      			Messenger.instance.obtenermensa("Evento deshabilitado") 
      		end
    		redirect_to "/event/viewnotaceptedevents"
    	else
    		Messenger.instance.obtenermensa("Error al habilitar/deshabilitar evento") 
    		redirect_to "/event/viewnotaceptedevents"
  		end
	end

	def view #Va a la pantalla del evento (get)
		@evento = Event.find(params[:id])
	end

	def viewnotaceptedevents #Va a la pantalla de control de eventos (get)
		if(current_user == nil)
			redirect_to root_url
		else
			if(current_user.Admi == false)
				redirect_to root_url
			end
		end
		@evento = Event.all
	end

	private

	def user_params
    	params.require(:event).permit(:description, :direction, :enable, :iduser, :name, :tipo, :date_modify, :date_create)
    	params.require(:user).permit(:Name, :LastName, :Admi)
  	end

end
