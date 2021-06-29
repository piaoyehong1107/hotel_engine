class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.string :term
      t.text :data

      t.timestamps
    end
  end
end
