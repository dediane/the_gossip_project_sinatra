require 'bundler'
Bundler.require

require 'gossip'
require 'comment'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  #permet de creer un nouveau potin
  get '/gossips/new/' do
    erb :new_gossip
  end

  #sauvegarde le nouveau potin et redirige vers le menu principal
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  #affiche les détails du potin selectionner
	get '/gossips/:id' do
		erb :show, locals: {gossip: Gossip.all[params[:id].to_i ], id: params[:id].to_i, comments: Comment.select_by_id(params[:id].to_i)}
  end

  #sauvegarde le nouveau commentaire
  post '/gossips/:id' do
		Comment.new(params[:id], params["comment_author"], params["comment_content"]).save
    erb :show, locals: {gossip: Gossip.all[params[:id].to_i ], id: params[:id].to_i, comments: Comment.select_by_id(params[:id].to_i)}
	end
  
  #permet d'éditer un commentaire
  get '/gossips/:id/edit/' do
    erb :edit, locals: {gossip: Gossip.all[params[:id].to_i ], id: params[:id].to_i}
  end

  #sauvegarde et met a jour le fichier csv avec les modifications
  post '/gossips/:id/edit/' do
		Gossip.upgrade(params["gossip_author"], params["gossip_content"], params[:id].to_i)
		redirect '/'
  end

end
  
