# frozen_string_literal: true

# Tic Tac Toe Game
class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(3) { Array.new(3, nil) }
  end

  def display
    puts '  1 2 3'
    @grid.each_with_index do |row, i|
      row_string = row.map { |cell| cell.nil? ? ' ' : cell }.join('|')
      puts "#{i + 1} #{row_string}"
      puts '  - - -' unless i == 2
    end
  end

  def empty?
    @grid.all? { |row| row.all?(&:nil?) }
  end

  def full?
    @grid.none? { |row| row.any?(&:nil?) }
  end

  def winner
    (rows + columns + diagonals).each do |triple|
      return 'X' if triple == %w[X X X]
      return 'O' if triple == %w[O O O]
    end
    nil
  end

  private

  def rows
    @grid
  end

  def columns
    @grid.transpose
  end

  def diagonals
    [
      [@grid[0][0], @grid[1][1], @grid[2][2]],
      [@grid[0][2], @grid[1][1], @grid[2][0]]
    ]
  end
end

# Player
class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end

  def move
    print "#{@name}, enter your move (row column): "
    gets.chomp.split(' ').map(&:to_i)
  end
end

# Game
class Game
  def initialize
    @board = Board.new
    @players = [Player.new('Player 1', 'X'), Player.new('Player 2', 'O')]
    @current_player = @players[0]
  end

  def play
    display_board
    loop do
      play_turn
      break if winner? || tie?
    end
    puts end_message
  end

  def display_board
    @board.display
  end

  def play_turn
    row, col = @current_player.move
    if valid_move?(row, col)
      @board.grid[row - 1][col - 1] = @current_player.marker
      display_board
      # if winner? || tie?
      #   puts end_message
      #   break
      # end
      switch_player
    else
      puts 'That is not a valid move. Try again.'
    end
  end

  private

  def valid_move?(row, col)
    (1..3).include?(row) && (1..3).include?(col) && @board.grid[row - 1][col - 1].nil?
  end

  def winner?
    @board.winner == 'X' || @board.winner == 'O'
  end

  def tie?
    @board.full? && @board.winner.nil?
  end

  def switch_player
    @current_player = @current_player == @players[0] ? @players[1] : @players[0]
  end

  def end_message
    if @board.winner
      "#{@current_player.name} wins!"
    else
      'Tie game!'
    end
  end
end

#Game.new.play