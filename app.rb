require 'sinatra'

get '/' do
  erb :index
end

get '/id' do
  erb :person
end
