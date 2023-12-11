require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ("a".."z").to_a.sample(10)
  end

  def score
    @long_word = params[:longWord]
    @letters = params[:letters]

    @exists = search_word(@long_word)
    if @long_word.chars.all? { |letter| @long_word.count(letter) <= @letters.count(letter) } && @exists
      @validation =  "congratulations #{@long_word} is a valid English word!"
    else
      @validation =  "you idiot ,#{@long_word} is not real"
    end


  end

  private

  def search_word(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    parsed = JSON.parse(response.read)
    parsed["found"]
  end
end
