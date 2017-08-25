ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require './data_mapper_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions

  helpers do
    def current_user
      @current_user ||= User.find(session[:user])
    end
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/' do
    redirect '/links'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url: params[:url],
                title: params[:title])
    params[:name].split.each do |tag|
      link.tags << Tag.first_or_create(name: tag)
    end
    link.save
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.new(first_name: params[:first_name],
                    surname:    params[:surname],
                    email:     params[:email],
                    password:   params[:password])
    if user.save
      session[:user] = user.id
      redirect to '/links'
    else
      redirect to 'users/new'
    end
  end
end
