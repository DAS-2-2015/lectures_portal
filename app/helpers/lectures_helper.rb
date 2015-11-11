module LecturesHelper
  def get_time_zone auth_client, api_client, calendar
    zone = api_client.execute(:api_method => calendar.calendars.get,
      :authorization => auth_client,
      :parameters => {
        'field' => "timeZone",
        'calendarId' => 'primary'})
    zone.data.timeZone
  end

  def check_availability auth_client, lecture
    api_client = Google::APIClient.new
    calendar = api_client.discovered_api('calendar', 'v3')

    zone = get_time_zone auth_client, api_client, calendar
    date = lecture.date
    date_transformed = date.in_time_zone(zone).to_datetime

    result_date = DateTime.parse(date.strftime("%d %b %Y %H:%M:%S #{date_transformed.formatted_offset}"))

    list = api_client.execute(:api_method => calendar.events.list,
      :authorization => auth_client,
      :parameters => {
        'maxResults' => 20,
        'timeMin' => result_date.to_s,
        'timeMax' => (result_date + lecture.duration * 60).to_s,
        'calendarId' => 'primary'})

    return list.data.items.count == 0
  end

  def get_token
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

  def create_event auth_client, lecture
    api_client = Google::APIClient.new
    calendar = api_client.discovered_api('calendar', 'v3')

    new_event = calendar.events.insert.request_schema.new
    new_event.start = { 'dateTime' => lecture.date }
    new_event.end = { 'dateTime' => lecture.date + lecture.duration * 60}
    new_event.location = 'Location'
    new_event.description = lecture.description
    new_event.summary = lecture.title
    result = api_client.execute(:api_method => calendar.events.insert,
      :authorization => auth_client,
      :parameters => { 'calendarId' => 'primary'},
      :headers => {'Content-Type' => 'application/json'},
      :body_object => new_event)
  end
end
