module ActivityReportHelper
  def presentable_time(seconds)
    total_minutes = seconds.to_i / 60
    hours = total_minutes / 60
    minutes = total_minutes % 60

    return "#{hours}h" if minutes.zero?

    "#{hours}:#{minutes.to_s.rjust(2, '0')}"
  end
end
