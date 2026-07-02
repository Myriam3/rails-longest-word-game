require 'open-uri'
require 'json'

class GameController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample}
  end

  def check_english(word)
    return JSON.parse(URI.parse("https://dictionary.lewagon.com/#{word}").read)["found"]
  end

  def check_grid_error(word, letters)
    available_letters = letters.dup

    word.upcase.chars.each do |letter|
      index = available_letters.index(letter.upcase)

      if index
        available_letters.delete_at(index)
      else
        return "The letter #{letter} is not available"
      end

      return nil
  end

  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @error = nil

    return if !@letters

    @error = check_grid_error(@word, @letters)

    if !@error && !check_english(@word)
      @error = "Not an English word"
    end

    # The word is valid according to the grid and is an English word
  end
end
