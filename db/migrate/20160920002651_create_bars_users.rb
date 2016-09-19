class CreateBarsUsers < ActiveRecord::Migration
  def change
    create_table :bars_users do |t|
      t.integer :user_id
      t.integer :bar_id
    end
  end
end
