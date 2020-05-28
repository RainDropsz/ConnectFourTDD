# frozen_string_literal: true

# Player
class Player
  attr_reader :number, :marker, :name

  def initialize(number)
    @number = number
    @name = "Player #{@number}"
    @marker = number.odd? ? '●' : '○'
  end

  def gets_name
    puts "Player #{number} name: "
    name = gets.chomp
    @name = name unless name.empty?
  end
end
