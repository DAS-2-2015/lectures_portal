OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '191320974537872', '65ebfa58974e0f401f7ddbfa6a1c7d3d',
    display: :popup
end