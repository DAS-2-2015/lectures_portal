FactoryGirl.define do

  factory :notification do

  end
  factory :follower do

  end
  factory :enrollment do

  end

  factory :user do
    provider "facebook"
    uid "883752575012371021"
    name "Barack Putin"
    image "http://graph.facebook.com/883752575071021/picture"
    token "CAACuAWK5tJABasdAL9DlOFrppNHAZCgyyeuBGaIhsMm6J8lBNnIE..."
    expires_at "2016-01-18 19:41:27"
    created_at "2015-11-19 21:42:05"
    updated_at "2015-11-19 21:42:05"
  end

  factory :user_update do
    provider "facebook"
    uid "883752575012371021"
    name "BrBr"
    image "http://graph.facebook.com/883752575071021/picture"
    token "CAACuAWK5tJABasdAL9DlOFrppNHAZCgyyeuBGaIhsMm6J8lBNnIE..."
    expires_at "2016-01-18 19:41:27"
    created_at "2015-11-19 21:42:05"
    updated_at "2015-11-19 21:42:05"
  end

  factory :lecture do
    title "Palestra do momento"
    theme "huehue"
    address "asdsada"
    description "Descrição da palestra 1"
    price "0.0"
    duration "1"
    latitude "-23.7344773"
    longitude "-46.5717531"
    date "2015-11-19 21:40:50"
    created_at "2015-11-19 21:40:50"
    updated_at "2015-11-19 21:40:50"
    speaker_id "1"
  end
  factory :lecture_update do
    title "Palestra do momento"
    theme "huehue"
    address "asdsada"
    description "Descrição da palestra 1"
    price "0.0"
    duration "2"
    date "2015-11-19 21:40:50"
    created_at "2015-11-19 21:40:50"
    updated_at "2015-11-19 21:40:50"
    speaker_id "1"
  end

  factory :invalid_lecture do
    title "Palestra do momento"
    theme "huehue"
    address "asdsada"
    description "Descrição da palestra 1"
    price "0.0"
    duration "1"
    date "asda"
    created_at "asd"
    updated_at "2015-11-19 21:40:50"
    speaker_id "1"
  end

end
