class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user, index: true
      t.string :message
      t.boolean :displayed, default: false
      t.timestamps null: false
    end
  end
end
