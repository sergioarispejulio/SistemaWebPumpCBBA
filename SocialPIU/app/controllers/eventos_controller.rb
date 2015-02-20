class EventosController < ApplicationController

	def new
	end

	def create
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
				redirect_to :controller => :start, :method => :index, :messeange => "Evento creado"
			else
				redirect_to :controller => :start, :method => :index, :messeange => "Evento creado, esperar hasta que un administrador valide el evento"
			end
    	else
    		redirect_to :controller => :eventos, :method => :new, :messeange => "Error al crear el evento, vuelva a intentarlo"
  		end
	end

	def delete
		@evento = Event.find(params[:id])
      	@evento.destroy
      	redirect_to "/event/viewnotaceptedevents", :messeange => "Evento eliminado"
	end

	def edit
		@evento = Event.find(params[:id])
	end

	def update
		@evento = Event.find(params[:id])
		@evento.description = params[:Description]
		@evento.tipo = params[:tipo]
		@evento.direction= params[:Direction]
		@evento.name = params[:Name]
		@evento.iduser = params[:Iduse]
		@evento.date_modify = params[:Fecha]
		if @evento.save
    		redirect_to "/event/"+params[:id], :messeange => "Evento editado"
    	else
    		redirect_to :controller => :eventos, :method => :edit, :id => params[:id], :messeange => "Error al editar evento, vuelva a intentarlo"
  		end
	end

	def accept
		@evento = Event.find(params[:id])
      	@evento.enable = true
      	if @evento.save
    		redirect_to "/event/viewnotaceptedevents", :messeange => "Evento aceptado"
    	else
    		redirect_to "/event/viewnotaceptedevents", :messeange => "Error al aceptar evento"
  		end
	end

	def view
		@evento = Event.find(params[:id])
	end

	def viewnotaceptedevents
		@evento = Event.where(:enable => false)
	end

	private

	def user_params
    	params.require(:event).permit(:description, :direction, :enable, :iduser, :name, :tipo, :date_modify, :date_create)
    	params.require(:user).permit(:Name, :LastName, :Admi)
  	end

end
