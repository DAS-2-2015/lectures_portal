json.array!(@lectures) do |lecture|
  json.extract! lecture, :id, :title, :description, :duration, :date
  json.url lecture_url(lecture, format: :json)
end
