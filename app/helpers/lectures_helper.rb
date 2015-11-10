module LecturesHelper
  def get_token()
    client_secrets = Google::APIClient::ClientSecrets.load
    auth_client = client_secrets.to_authorization
    auth_client.update!(
      scope: 'https://www.googleapis.com/auth/calendar',
      access_type: "offline",
      approval_prompt:'force',
      redirect_uri: "http://localhost:3000/lectures/#{params[:id]}/enroll?current_user_id=#{params[:current_user_id]}"
    )

    current_user = User.find(params[:current_user_id])
    result = [true, auth_client]

    if current_user.calendar_token == nil and params[:code] == nil
      result[0] = false
    elsif params[:code]
      auth_client.code = params[:code]
      auth_client.fetch_access_token!
      current_user.calendar_token = auth_client.refresh_token
      current_user.save
    end
    return result
  end

  def create_event(auth_client, lecture)
    api_client = Google::APIClient.new
    cal = api_client.discovered_api('calendar', 'v3')

    new_event = cal.events.insert.request_schema.new
    new_event.start = { 'dateTime' => lecture.date }
    new_event.end = { 'dateTime' => lecture.date + lecture.duration * 60}
    new_event.location = 'Location'
    new_event.description = lecture.description
    new_event.summary = lecture.title
    result = api_client.execute(:api_method => cal.events.insert,
      :authorization => auth_client,
      :parameters => { 'calendarId' => 'primary'},
      :headers => {'Content-Type' => 'application/json'},
      :body_object => new_event)
  end
end
