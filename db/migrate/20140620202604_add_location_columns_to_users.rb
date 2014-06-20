class AddLocationColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :locale, :string
    add_column :users, :hometown, :string

  end
end
