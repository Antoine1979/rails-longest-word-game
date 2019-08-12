require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = generate_grid(10).join(' ')
  end

  def score
    @letters = params[:letters]
    @word = params[:result]
    if english?(@word)
      if @word.upcase.chars.all? { |letter| @letters.include?(letter) }
        @result = "Congratualtions! #{@word} is an english word !!"
      else
        @result = "Sorry but #{@word} can't seem to be built out of #{@letters}"
      end
    else
      @result = "Sorry #{@word} doesn't seem to be a valid english word"
    end
  end

  private

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a[rand(26)] }
  end

  def english?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    result = JSON.parse(response.read)
    result['found']
  end
end
