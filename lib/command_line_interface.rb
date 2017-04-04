def welcome
  puts "Welcome to the Star Wars API Lab!"
  selection = "invalid"
  while selection == "invalid"
    puts "Please select search by 1. Movies or 2. Characters"
    num = gets.chomp.to_i
    selection = validate_selection(num, 2)
  end
  if num == 1
    puts "You selected Movies ... searching for all the titles of Star Wars movies."
  else
    puts "You selected Characters ... searching for the names of all the Star Wars chracters."
  end
  num
end

def puts_characters
  characters = all_characters
  characters.each_index do |i|
    puts "#{i+1}. #{characters[i]}"
  end
end

def puts_films
  films = all_films
  films.each_index do |i|
    puts "#{i + 1}. #{films[i]}"
  end
end

def get_character_from_user
  characters = all_characters
  puts_characters
  selection = "invalid"
  while selection == "invalid"
    puts "Please enter a charcter (by number)"
    num = gets.chomp.to_i
    selection = validate_selection(num, characters.count)
  end
  puts "You selected #{characters[num -1]} ... finding the movies he, she or it appeared!"
  characters[num - 1]
end

def get_movie_from_user
  films = all_films
  puts_films
  selection = "invalid"
  while selection == "invalid"
    puts "Please enter a movie (by number)"
    num = gets.chomp.to_i
    selection = validate_selection(num, films.count)
  end
  puts "You selected #{films[num -1]} ... finding the characters in selected movie"
  films[num -1]
end

def validate_selection(num, count)
  if num > 0 && num < count + 1
    return "valid"
  else
    puts "Invalid Selection"
    return "invalid"
  end
end
