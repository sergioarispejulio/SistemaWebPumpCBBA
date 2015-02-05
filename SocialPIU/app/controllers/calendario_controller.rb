class CalendarioController < ApplicationController

	def viewcalendario
		if(params[:ano] != nil && params[:mes] != nil)
			@ano = params[:ano].to_i
			@mes = params[:mes].to_i
			@diasemana= Date.new(@ano,@mes,1).strftime("%A")
		else			
			@ano = Date.today.year
			@mes = Date.today.month 
			@diasemana= Date.new(@ano,@mes,1).strftime("%A")
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
		@lista = Event.where(:enable => true, :date_modify => Date.new(@ano,@mes,1)..Date.new(@ano,@mes,@dias))
		if ((@diasemana <=> "Monday") == 0 )
			@recorrer = 1
		end
		if ((@diasemana <=> "Tuesday") == 0)
			@recorrer = 2
		end
		if ((@diasemana <=> "Wednesday") == 0)
			@recorrer = 3
		end
		if ((@diasemana <=> "Thursday") == 0)
			@recorrer = 4
		end
		if ((@diasemana <=> "Friday") == 0)
			@recorrer = 5
		end
		if ((@diasemana <=> "Saturday") == 0)
			@recorrer = 6
		end
		if ((@diasemana <=> "Sunday") == 0)
			@recorrer = 0
		end
		@i=0
		@tot = @lista.length
		@cont = 1
	end

	def new
	end


	private

	def user_params
    	params.require(:event).permit(:description, :direction, :enable, :iduser, :name, :tipo, :date_modify)
  	end

end
