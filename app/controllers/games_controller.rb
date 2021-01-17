require "open-uri"
class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
   end

  def score
    @letters = params[:letters]
    @word = params[:word]
    @valid_word = valid_word?(@word)
    @included = included?(@word, @letters)

  end

  private
  
  def words_params
    params.require(:game).permit(:words)
  end

  def valid_word?(word)
    JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{word}").read)["found"]
  end

  def included?(word, letters)
    word.upcase.chars.all? { |letter| word.upcase.count(letter) <= letters.count(letter) }
  end

end
