class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
    
  end

  def word
    @word
  end

  def guess(char)
    if char == nil
      raise ArgumentError
    end
    char = char.downcase
    if char.length == 0 || !('a'..'z').cover?(char)
      raise ArgumentError
    end
    
    if word.include? char
      if !guesses.include? char
        @guesses += char
      else
        return false
      end
    else
      if !wrong_guesses.include? char
        @wrong_guesses += char
      else
        return false
      end
    end
    return true
  end

  def guesses
    @guesses
  end

  def wrong_guesses
    @wrong_guesses
  end

  def word_with_guesses
    display = ""
    word.split("").each do |c|
      if !guesses.include?(c)
        display += "-"
      else
        display += c
      end
    end
    return display
  end

  def check_win_or_lose
    if wrong_guesses.length >= 7
      return :lose
    end
    if word_with_guesses == word
      return :win
    end
    return :play
  end


  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
