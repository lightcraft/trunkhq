module ApplicationHelper
  def convert_seconds_to_time(seconds)
    total_minutes = seconds.to_i / 1.minutes
    seconds_in_last_minute = seconds.to_i - total_minutes.minutes.seconds
    total_minutes >  0 ? "#{total_minutes}m #{seconds_in_last_minute}s" : "#{seconds_in_last_minute}s"
  end
end
