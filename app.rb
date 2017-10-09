require 'sinatra'

def readJson
  json = File.read('people.json')
  @customers = JSON.parse(json)
  @people = @customers['people']
end

get '/' do
  erb :index
end

get '/id' do
  erb :person
end
