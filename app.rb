require "sinatra/activerecord"
require 'sinatra'

Dir["./app/models/*.rb"].each { |file| require file }

get '/' do
  if params[:username].present?
    user = User.where(username: params[:username]).first_or_create
    user.user_agent = request.user_agent
    user.ip = request.ip
    user.save!
    "Yo"
  else
    "Yo"
  end
end
