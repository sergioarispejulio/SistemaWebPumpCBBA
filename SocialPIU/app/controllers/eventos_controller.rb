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
    		redirect_to :controller => :start, :method => :index
    	else
    		redirect_to :controller => :eventos, :method => :new
  		end
	end

	def delete
		@evento = Event.find(params[:id])
      	@evento.destroy
      	redirect_to :controller => :eventos, :method => :viewnotaceptedevents
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
    		redirect_to "/event/"+params[:id]
    	else
    		redirect_to :controller => :eventos, :method => :edit, :id => params[:id]
  		end
	end

	def accept
		@evento = Event.find(params[:id])
      	@evento.enable = true
      	if @evento.save
    		redirect_to :controller => :eventos, :method => :viewnotaceptedevents
    	else
    		redirect_to :controller => :eventos, :method => :viewnotaceptedevents
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
