class AddAttendeesToBars < ActiveRecord::Migration
  def change
    add_column :bars, :attendees, :integer
  end
end
