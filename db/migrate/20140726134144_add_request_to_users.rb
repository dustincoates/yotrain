class AddRequestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_agent, :text
    add_column :users, :ip, :text
  end
end
