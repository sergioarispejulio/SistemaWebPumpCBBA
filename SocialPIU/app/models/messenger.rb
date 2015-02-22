require "singleton"

class Messenger
	include Singleton

	def initialize
    	@mensa = ""
  	end

  	def devolvermensa
  		return @mensa
  	end

  	def obtenermensa(mensaje)
  		@mensa = mensaje
  	end

  	def limpiar
  		@mensa = ""
  	end

end