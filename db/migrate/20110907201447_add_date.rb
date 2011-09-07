class AddDate < ActiveRecord::Migration
  def self.up
   change_table :jes do |t|
      t.integer :debit
      t.integer :credit
      t.integer :amount
      t.string :comment
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :jes
  end

end
