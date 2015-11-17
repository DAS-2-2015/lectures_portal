class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.belongs_to :user, index: true
      t.belongs_to :panelist, index: true
    end
  end
end
