# frozen_string_literal: true

require 'rspec'
require_relative '../lib/tictactoe'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
describe Game do
  describe '#initialize' do
    let(:game) { Game.new }
    let(:board) { game.board }

    it 'creates a new board' do
    end
  end

  describe '#play' do
    let(:game) { Game.new }

    it 'should display the board and end the game when there is a winner' do
      allow(game).to receive(:play_turn).and_return(nil)
      allow(game).to receive(:winner?).and_return(true)
      allow(game).to receive(:tie?).and_return(false)
      allow(game).to receive(:display_board)
      allow(game).to receive(:puts).with('Game over! Player 1 wins!')
    end

    it 'should display the board and end the game when there is a tie' do
      allow(game).to receive(:play_turn).and_return(nil)
      allow(game).to receive(:winner?).and_return(false)
      allow(game).to receive(:tie?).and_return(true)
      allow(game).to receive(:display_board)
      allow(game).to receive(:puts).with('Game over! It\'s a tie!')
    end

    it 'should display the board and continue the game when there is no winner or tie' do
      allow(game).to receive(:play_turn).and_return(nil)
      allow(game).to receive(:winner?).and_return(false)
      allow(game).to receive(:tie?).and_return(false)
      allow(game).to receive(:display_board).twice
    end
  end

  describe '#display_board' do
    let(:game) { Game.new }
    let(:board) { game.board }

    it 'should display the board' do
      expect { game.display_board }.to output("  1 2 3\n1  | | \n  - - -\n2  | | \n  - - -\n3  | | \n").to_stdout
    end
  end

  describe '#play_turn' do
    let(:game) { Game.new }
    let(:board) { game.board }

    it 'should play a turn' do
      allow(game).to receive(:play_turn)
    end

    it 'should switch the current player' do
      allow(game).to receive(:switch_player)
    end

    it 'should display the board' do
      allow(game).to receive(:display_board)
    end

    it 'should check for a winner' do
      allow(game).to receive(:winner?)
    end

    it 'should check for a tie' do
      allow(game).to receive(:tie?)
    end

    it 'should end the game' do
      allow(game).to receive(:end_message)
    end

    it 'should display the end message' do
      allow(game).to receive(:puts)
    end
  end

  describe '#end_message' do
    let(:game) { Game.new }
    let(:board) { game.board }

    it 'should return the end message' do
      allow(game).to receive(:end_message).and_return('Game over! Player 1 wins!')
    end

    it 'should return the tie message' do
      allow(game).to receive(:end_message).and_return('Game over! It\'s a tie!')
    end
  end
end
# rubocop:enable Metrics/BlockLength

# rubocop:disable Metrics/BlockLength
describe Board do
  describe '#initialize' do
    let(:board) { Board.new }

    # tests for a 3 by 3 grid with nil values
    it 'creates a 3x3 grid' do
      expect(board.grid).to eq(Array.new(3) { Array.new(3, nil) })
    end
  end

  describe '#display' do
    let(:board) { Board.new }
    let(:grid) { board.grid }

    it 'displays the board' do
      expect { board.display }.to output("  1 2 3\n1  | | \n  - - -\n2  | | \n  - - -\n3  | | \n").to_stdout
    end
  end

  describe '#empty?' do
    let(:board) { Board.new }
    let(:grid) { board.grid }

    it 'returns true if the board is empty' do
      expect(board.empty?).to be true
    end
  end

  describe '#full?' do
    let(:board) { Board.new }
    let(:grid) { board.grid }

    it 'returns false if the board is not full' do
      expect(board.full?).to be false
    end

    it 'returns true if the board is full' do
      grid[0][0] = 'X'
      grid[0][1] = 'X'
      grid[0][2] = 'X'
      grid[1][0] = 'X'
      grid[1][1] = 'X'
      grid[1][2] = 'X'
      grid[2][0] = 'X'
      grid[2][1] = 'X'
      grid[2][2] = 'X'
      expect(board.full?).to be true
    end
  end

  describe '#winner' do
    let(:board) { Board.new }
    let(:grid) { board.grid }

    it 'returns nil if there is no winner' do
      expect(board.winner).to be nil
    end

    it 'returns the winning marker if there is a winner' do
      grid[0][0] = 'X'
      grid[0][1] = 'X'
      grid[0][2] = 'X'
      expect(board.winner).to eq('X')
    end
  end
end
# rubocop:enable Metrics/BlockLength

describe Player do
  describe '#initialize' do
    let(:player) { Player.new('Player 1', 'X') }

    it 'creates a player with a name and marker' do
      expect(player.name).to eq('Player 1')
      expect(player.marker).to eq('X')
    end
  end

  describe '#move' do
    let(:player) { Player.new('Player 1', 'X') }

    before do
      allow($stdout).to receive(:puts).with('Player 1, enter your move (row column): ')
      allow($stdin).to receive(:gets).and_return('1 2')
    end

    it 'prompts the player to enter a move' do
    end

    it 'splits the input into two integers' do
    end

    it 'returns the row and column as an array' do
    end
  end
end
