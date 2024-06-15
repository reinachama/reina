class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :name
      t.date :date
      t.string :place
      t.string :genre
      t.string :organizer
      t.text :about

      t.timestamps
    end
  end
end
