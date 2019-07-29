require 'gossip'
require 'csv'

#Création d'une classe qui hérite de la classe Sinatra::Base (donc elle a les même fonctionnalité e bases que Sinatra)
class ApplicationController < Sinatra::Base
	get '/' do
	#Permet à Sinatra de comprendre qu'il doit aller choper le fichier index qui se trouve dans views
	erb :index, locals: {gossips: Gossip.all}
	end

	get	'/gossips/new/' do
	erb	:new_gossip
	end

	#Ces lignes permettent de récupérer le nom et le contenu publié par notre "gossip man" ou "gossip girl" et de les stocker dans une BDD	
	post '/gossips/new/' do
	
		Gossip.new(params["gossip_author"],params["gossip_content"]).save
		redirect '/'
	end
	#Permet de faire appel à la page show qui renvoit à l'aide d'une url dynamique le contenu d'un potin spécifique
	get '/gossips/:id/' do
		erb :show, locals: {gossips: Gossip.find(params['id'].to_i)} 
	end

end

