class CreateQuote < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :added_nick
      t.string :quote
      t.timestamps
    end
  end
end
