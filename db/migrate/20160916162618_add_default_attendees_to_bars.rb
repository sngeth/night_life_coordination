class AddDefaultAttendeesToBars < ActiveRecord::Migration
  def change
    change_column :bars, :attendees, :integer, default: 0
  end
end
