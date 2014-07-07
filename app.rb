require "sinatra/activerecord"
require 'sinatra'

Dir["./app/models/*.rb"].each { |file| require file }

get '/' do
  if params[:username].present?
    User.where(username: params[:username]).first_or_create
    "Yo"
  else
    "Yo"
  end
end
