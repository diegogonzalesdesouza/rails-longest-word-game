require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    # @letters = ('A'..'Z').to_a.sample(10)
    @letters = ['L', 'I', 'E', 'A', 'B', 'N']
  end

  def score
    @word = params[:word]
    url_english_word = "https://wagon-dictionary.herokuapp.com/#{@word}"
    api_word_serialized = open(url_english_word).read
    @api_word = JSON.parse(api_word_serialized)

    # is a valid English word
    @letters = params[:letters].downcase.split('')

    if ary_diff?(@word, @letters)
      valid_word?(@word)
    else
      @message = "Sorry but #{@word} can't be build from #{@letters}"
    end
  end

  def ary_diff?(word, letters)
    # create ary from  user input
    word = word.downcase.split('')
    # returns true if user input is exactly like the initersection of user input with letters ary
    word == word & letters
  end

  def valid_word?(word)
    if @api_word['found']
      @message = 'word exists!'
    else
      @message = "#{word} is not a valid English Word!"
    end
  end
end
