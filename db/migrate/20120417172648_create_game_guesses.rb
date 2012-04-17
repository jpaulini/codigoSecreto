class CreateGameGuesses < ActiveRecord::Migration
  def change
    create_table :game_guesses do |t|
      t.references :game
      t.string :code
      t.integer :ord

      t.timestamps
    end
    add_index :game_guesses, :game_id
  end
end
