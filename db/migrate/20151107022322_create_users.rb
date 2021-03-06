class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :image
      t.string :token
      t.datetime :expires_at
      t.belongs_to :review, index: true
      t.decimal :rate, default: 0.0

      t.timestamps null: false
    end
  end
end
