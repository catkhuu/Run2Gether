zips = [[10002, 40.72001, -73.993787], [10003, 40.731251, -73.98922],  [10009, 40.726189, -73.979591],  [10463, 40.878948, -73.907277],  [10471, 40.913575, -73.908619]]

experience_options = ['Beginner', 'Intermediate','Advanced', 'Competitive']

50.times do
  random = zips.sample
  User.create!( name: Faker::Name.first_name,
                email: Faker::Internet.email,
                password: 'password',
                zipcode: random[0],
                password_confirmation: 'password')
  end

User.all.each do |user|
  Profile.create!(  why_i_run: Faker::StarWars.quote,
                    goals: Faker::ChuckNorris.fact,
                    experience: experience_options.sample,
                    user: user,
                    need_to_knows: Faker::Superhero.power)
                  end

# future_runs = [Faker::Time.forward(30, :morning), Faker::Time.forward(30, :afternoon), Faker::Time.forward(30, :evening)]

# 250.times do
#   runner = User.all.sample
#   Run.create!(  distance: rand(2..15),
#                 run_time: Faker::Time.forward(23, :morning),
#                 run_pace: Faker::Time.forward(23, :morning),
#                 runner: User.all.sample,
#                 companion: User.all.sample,
#                 run_date: future_runs.sample,
#                 time: Faker::Time.forward(23, :morning),
#                 zipcode: zips.sample)
# end
# #
# previous_runs = [Faker::Time.backward(30, :morning), Faker::Time.backward(30, :afternoon), Faker::Time.backward(30, :evening)]
#
# 250.times do
#   runner = User.all.sample
#   mood = Mood.where(user: runner).sample
#   Run.create!(  distance: rand(2..15),
#                 run_time: Faker::Time.backward(23, :morning),
#                 run_pace: Faker::Time.forward(23, :morning),
#                 runner: User.all.sample,
#                 companion: User.all.sample,
#                 run_date: previous_runs.sample,
#                 time: Faker::Time.forward(23, :morning),
#                 zipcode: zips.sample,
#                 mood_id: mood)
# end



# more_seconds = 480
# more_pace = Time.at(more_seconds).utc.strftime('%H:%M:%S')
#
# Mood.create!(name: 'The afternoon special', mood_pace: more_pace, mood_experience: 'Beginner', desired_distance: 4, user: lindsay)
#
# Mood.create!(name: 'Saucy', mood_experience: 'Competitive', user: matt)
#
# Mood.create!(name: 'Many the Miles', desired_distance: 10, user: miles)
#
# Mood.create!(name: 'Brisk', desired_distance: 3.5, user: meow)
#
# even_more_seconds = 1500
# more_time = Time.at(even_more_seconds).utc.strftime('%H:%M:%S')
#
# def converted_pace(seconds, distance)
#   pace_seconds = seconds/distance
#   Time.at(pace_seconds).utc.strftime('%H:%M:%S')
# end
#
# Run.create!(runner_id: 1, run_date: "30 November, 2016", time: 43200, zipcode: 10004)
# Run.create!(runner_id: 2, run_date: "29 November, 2016", time: 48000, zipcode: 10004)
# Run.create!(runner_id: 3, run_date: "29 November, 2016", time: 48000, zipcode: 10004)
# Run.create!(runner_id: 4, run_date: "28 November, 2016", time: 43200, zipcode: 10004)

# lindsay = User.create!(name: 'Lindsay Kelly', email: 'lindsay@mail.com', password: 'password', location: 'Brooklyn', password_confirmation: 'password')
# matt = User.create!(name: 'Matt Critelli', email: 'matthew@mail.com', password: 'password', location: 'Brooklyn', password_confirmation: 'password')
# miles = User.create!(name: 'Miles McSomething', email: 'runningmiles@mail.com', password: 'password', location: 'Financial District', password_confirmation: 'password')
# meow = User.create!(name: 'Catherine Khuu', email: 'catherine@mail.com', password: 'password', location: 'The Heights', password_confirmation: 'password')

# Profile.create!(why_i_run: 'To get away from people', user_pace: pace, experience: 'Beginner', user: lindsay, goals: 'to be the very best like no one ever was', need_to_knows: 'destroyed meniscus')
# Profile.create!(why_i_run: 'To challenge myself', user_pace: pace, experience: 'Intermediate', user: matt, goals: 'to compete in the Iron Man Triathlon with my dog')
# Profile.create!(why_i_run: 'To stay fit', user_pace: pace, experience: 'Competitive', user: miles, goals: 'to compete in the Iron Man Triathlon with my cat')
# Profile.create!(why_i_run: 'To relax and find some peace of mind', user_pace: pace, experience: 'Intermediate', user: meow, goals: 'to qualify for the Berlin Marathon in 2017', need_to_knows: 'I will stop if there is a corgi or any dog ')


# seconds = 240
# pace = Time.at(seconds).utc.strftime('%H:%M:%S')
