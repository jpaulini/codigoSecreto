class AddResultToGameGuesses < ActiveRecord::Migration
  def change
    add_column :game_guesses, :result, :integer
  end
end
