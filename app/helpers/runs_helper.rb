module RunsHelper
  def convert_hours_to_seconds(params)
    (params.to_i)*3600
  end

  def convert_minutes_to_seconds(params)
    (params.to_i)*60
  end

  def offset_time(run_hours)
    run_hours.to_i + 12
  end

  def convert_time(converted_hrs, converted_mins)
    hr_sec = convert_hours_to_seconds(converted_hrs)
    min_sec = convert_minutes_to_seconds(converted_mins)
    converted_time = hr_sec + min_sec
  end

  def find_midpoint(user_coord, result_coord)
    [(user_coord[0] + result_coord[0]) / 2 , (user_coord[1] + result_coord[1]) / 2 ]
  end
end
