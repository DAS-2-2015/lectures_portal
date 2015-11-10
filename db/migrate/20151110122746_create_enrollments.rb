class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.belongs_to :lecture, index: true
    	t.belongs_to :user, index: true
      t.boolean :status, default: false
      t.timestamps null: false
    end
  end
end
