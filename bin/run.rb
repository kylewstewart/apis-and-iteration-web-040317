#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

choice = welcome

if choice == 1
  movie = get_movie_from_user
  show_movies_characters(movie)
else
  character = get_character_from_user
  show_character_movies(character)
end
