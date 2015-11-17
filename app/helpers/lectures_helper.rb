module LecturesHelper

  @auth_client
  @api_client
  @calendar

  def init_auth_client
    if @auth_client.nil?
      client_secrets = Google::APIClient::ClientSecrets.load
      @auth_client = client_secrets.to_authorization
      @auth_client.update!(
        scope: 'https://www.googleapis.com/auth/calendar',
        access_type: "offline",
        approval_prompt:'force',
        redirect_uri: "http://localhost:3000/lectures/authorize/"
      )
    end
    if @api_client.nil?
      init_api_client
    end
  end

  def init_api_client
    @api_client = Google::APIClient.new
    @calendar = @api_client.discovered_api('calendar', 'v3')
  end

  def get_token
    init_auth_client

    if params[:code].nil?
      return false
    else
      @auth_client.code = params[:code]
      @auth_client.fetch_access_token!
    end

    return true
  end

  def get_time_zone
    zone = @api_client.execute(:api_method => @calendar.calendars.get,
      :authorization => @auth_client,
      :parameters => {
        'field' => "timeZone",
        'calendarId' => 'primary'})
    zone.data.timeZone
  end

  def transform_date lecture
    zone = get_time_zone
    date = lecture.date
    date_transformed = date.in_time_zone(zone).to_datetime

    result_date = DateTime.parse(date.strftime("%d %b %Y %H:%M:%S #{date_transformed.formatted_offset}"))
  end

  def check_availability lecture
    result_date = transform_date lecture

    list = @api_client.execute(:api_method => @calendar.events.list,
      :authorization => @auth_client,
      :parameters => {
        'maxResults' => 20,
        'timeMin' => result_date.to_s,
        'timeMax' => (result_date + lecture.duration.minutes).to_s,
        'calendarId' => 'primary'})

    return list.data.items.count == 0
  end

  def create_enrollment lecture
    unless check_availability lecture
      return "Not availability"
    end

    current_user = User.find params[:current_user_id]
    enrollment = Enrollment.new lecture_id: lecture.id, user_id: current_user.id
    
    if lecture.price == 0
      result_date = transform_date lecture
      
      if create_event lecture, result_date
        enrollment.status = true
      else
        return "Fail"
      end
    end
    
    enrollment.save
    return "Success"
  end

  def create_event lecture, result_date
    new_event = @calendar.events.insert.request_schema.new
    new_event.start = { 'dateTime' => result_date }
    new_event.end = { 'dateTime' => result_date + lecture.duration.minutes}
    new_event.location = 'Location'
    new_event.description = lecture.description
    new_event.summary = lecture.title
    result = @api_client.execute(:api_method => @calendar.events.insert,
      :authorization => @auth_client,
      :parameters => { 'calendarId' => 'primary'},
      :headers => {'Content-Type' => 'application/json'},
      :body_object => new_event)
  end

  def dispare_notifications
    followers = Follower.where(panelist_id: current_user.id).all

    followers.each do |f|
      Notification.create(message: "Nova palestra criada por #{current_user.name}", user_id: f.id)
    end
  end
end
