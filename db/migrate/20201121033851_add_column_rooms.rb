class AddColumnRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :group_judg, :boolean, default: false
  end
end
