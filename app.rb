require 'sinatra'

def readJson
  json = File.read('people.json')
  @customers = JSON.parse(json)
  @people = @customers['people']
end

def allPeople
    j = 0
    while j < @people.length
        date = Date.parse(@people[j]['dateOfBirth'])
        @people[j]['dateOfBirth'] = date.strftime('%B %-d %Y')
    j += 1
    end
end

def specificPerson
    i = 0
    while i < @people.length
        if @people[i]['id'] == params["id"]
            @person = @people[i]
        end
        i += 1
    end
end

get '/' do
  readJson
  allPeople

  erb :index
end

get '/id' do
  readJson
  specificPerson

  erb :person
end
