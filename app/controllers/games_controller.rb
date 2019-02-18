require 'json'
require 'open-uri'


class GamesController < ApplicationController
  def new
    charset = [*"A".."Z"]
    @letters = charset.sample(10)
  end

  def score
    @word = params[:word].upcase.split('')
    @grid = params[:grid].split(' ')
    @results = @grid.find_all do |letter|
      @word.include?(letter)
    end
    if @word.length > @results.length
      @display = "Triché!"
    else
      url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
      user_serialized = open(url).read
      user = JSON.parse(user_serialized)

      if user['found']
        @display = "Le mot #{@word}existe"
      else
        @display = "Ce mot #{@word}n'existe pas!"
      end
    end
  end
end