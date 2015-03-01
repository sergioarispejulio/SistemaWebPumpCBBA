# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@messange = "saj1010"<<"saj1010".reverse
@user = User.new
@user.password = "saj1010"
 @user.password_confirmation = "saj1010"
 @user.Actucontrasena = @messange.crypt("PUMPCBBA")
    @user.email =  "sergio_arispe@hotmail.com"
    @user.Type = "Jugador"
    @user.Name = "Sergio"
    @user.LastName = "Arispe Julio"
    @user.Genre = "Hombre"
    @user.Country = "Bolivia" 
    @user.City = "Cochabamba" 
    @user.Birthday = Date.new(1992,8,10)
    @user.Nickname = "SIANDJEX"
    @user.Enable = true
    @user.Admi = true
   @user.save
