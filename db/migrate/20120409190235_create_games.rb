class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
	t.string :secret_code
      t.timestamps
    end
  end
end
