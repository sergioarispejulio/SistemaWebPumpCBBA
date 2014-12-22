class CalendarioController < ApplicationController

	def viewcalendario
		if(params[:fecha] != nil)
			@ano = params[:fecha].year
			@mes = params[:fecha].month 
			@diasemana= params[:fecha].strftime("%A")
		else			
			@ano = Date.today.year
			@mes = Date.today.month 
			@diasemana= Date.today.strftime("%A")
		end
		if(@mes == 1 || @mes == 3 || @mes == 5 || @mes == 7 || @mes == 8 || @mes == 10 || @mes == 12) #31 dias
			@dias = 31
		else
			if(@mes == 2) # febrero
				if(@ano%4 == 0 || @ano%100 == 0)
					if(ano%400 == 0) # 29 dias
						@dias = 29
					else # 28 dias
						@dias = 28
					end
				else # 28 dias
					@dias = 28
				end

			else # 30 dias
				@dias = 30
			end
		end
		@lista = Event.where(:enable => true, :created_at => Date.new(ano,mes,1)..Date.new(ano,mes,dias))
	end

	def new
	end


	private

	def user_params
    	params.require(:event).permit(:description, :direction, :enable, :iduser, :name, :type)
  	end

end
