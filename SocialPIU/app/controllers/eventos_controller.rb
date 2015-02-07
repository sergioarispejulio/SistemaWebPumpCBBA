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
		@evento.enable = params[:Enable]
		@evento.date_create = Date.today
		@evento.date_modify = Date.today
		if @evento.save
    		redirect_to :controller => :start, :method => :index
    	else
    		redirect_to :controller => :eventos, :method => :new
  		end
	end

	def delete
	end

	def update
	end

	def accept
	end

	def view
		@evento = Event.find(params[:id])
	end

	private

	def user_params
    	params.require(:event).permit(:description, :direction, :enable, :iduser, :name, :tipo, :date_modify)
  	end

end
