class AddDate < ActiveRecord::Migration
  def self.up
   change_table :jes do |t|
      t.date :date

    end
  end

  def self.down
    drop_table :jes
  end

end
