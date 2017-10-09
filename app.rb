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

def bestMatches
    most_common = 0
    @best_matches = []
    z = 0
    while z < @people.length
        if @person['id'] != @people[z]['id']
            same = @person['hobbies'] & @people[z]['hobbies']
            if same.length > most_common
                most_common = same.length
                most_common_friend = @people[z]['name']
            end
        end
    z += 1
    end

    second_most_common = 0
    x = 0
    while x < @people.length
        if @person['name'] != @people[x]['name']
            if @people[x]['name'] != most_common_friend
                same_hobbies = @person['hobbies'] & @people[x]['hobbies']
                if same.length > second_most_common
                    second_most_common = same.length
                    second_most_common_friend = @people[x]['name']
                end
            end
        end
    x += 1
    end

    @best_matches.push(most_common_friend, second_most_common_friend)
end

get '/' do
  readJson
  allPeople

  erb :index
end

get '/:id' do
  readJson
  specificPerson
  bestMatches

  erb :person
end