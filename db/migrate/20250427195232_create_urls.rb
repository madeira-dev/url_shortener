class CreateUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :urls do |t|
      t.text :originalUrl, null: false
      t.string :slug, null: false
      t.integer :accessCount, default: 0

      t.timestamps
    end

    add_index :urls, :slug, unique: true
  end
end
