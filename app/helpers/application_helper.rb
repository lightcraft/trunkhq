module ApplicationHelper
  def convert_seconds_to_time(seconds)
    total_minutes = seconds.to_i / 1.minutes
    seconds_in_last_minute = seconds.to_i - total_minutes.minutes.seconds
    total_minutes >  0 ? "#{total_minutes}:#{seconds_in_last_minute}" : "00:#{seconds_in_last_minute}"
  end
end
