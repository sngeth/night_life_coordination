class RemoveAttendeesFromBars < ActiveRecord::Migration
  def change
    remove_column :bars, :attendees, :integer
  end
end
