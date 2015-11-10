class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :title
      t.string :description
      t.string :lecture_type
      t.integer :duration
      t.datetime :date

      t.timestamps null: false
    end
  end
end
