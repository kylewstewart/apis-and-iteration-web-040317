require 'rest-client'
require 'json'
require 'pry'

def call_api(url)
  api_array = []
  while url != nil
    json_str = RestClient.get(url)
    api_array << JSON.parse(json_str)
    url = api_array.last["next"]
  end
  api_array
end

def all_characters
  character_hash_array = call_api('http://www.swapi.co/api/people/')
  character_array = []
  character_hash_array.each do |character_hash|
    character_hash["results"].each {|data| character_array.push(data["name"])}
  end
  character_array.sort
end

def all_films
 films_hash_array = call_api('http://www.swapi.co/api/films/')
 film_array = []
 films_hash_array.each do |film_hash|
   film_hash["results"].each {|data| film_array << data["title"]}
 end
 film_array
end

def get_character_movies_from_api(character)
  character_hash_array = call_api('http://www.swapi.co/api/people/')
  films_hash = []
  character_hash_array.each do |character_hash|
    character_hash["results"].each do |data|
      if data["name"] == character
        data["films"].each {|url| films_hash.push(call_api(url))}
      end
    end
  end
  films_hash
end

def get_movie_characters_from_api(film)
  film_hash_array = call_api('http://www.swapi.co/api/films/')
  characters_hash = []
  film_hash_array.each do |film_hash|
    film_hash["results"].each do |character|
      if character["title"] == film
        character["characters"].each {|url| characters_hash.push(call_api(url))}
      end
    end
  end
  characters_hash
end

def parse_character_movies(films_hash)
  film_titles = []
  puts "Character not found" if films_hash[0] == nil
  films_hash.each do |film_hash|
    film_hash.each {|film| film_titles << film["title"]}
  end
  film_titles = film_titles.sort
  film_titles.each {|title| puts title}
end

def parse_movie_characters(characters_hash)
  character_names = []
  puts "Movie Not Found" if characters_hash[0] == nil
  characters_hash.each do |character_hash|
    character_hash.each {|character| character_names << character["name"]}
  end
  character_names = character_names.sort
  character_names.each {|name| puts name}
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

def show_movies_characters(film)
  characters_hash = get_movie_characters_from_api(film)
  parse_movie_characters(characters_hash)
end
