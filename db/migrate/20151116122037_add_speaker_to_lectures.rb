class AddSpeakerToLectures < ActiveRecord::Migration
  def change
    add_reference :lectures, :speaker, references: :user, index: true, foreign_key: true
  end
end
