class AddLocationToBars < ActiveRecord::Migration[5.0]
  def change
    add_column :bars, :location, :string
  end
end
