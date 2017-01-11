class Run < ApplicationRecord
  belongs_to :runner, foreign_key: :runner_id, class_name: :User
  belongs_to :companion, foreign_key: :companion_id, class_name: :User, optional: true
  validates :runner_id, :run_date, :time, :zipcode, presence: true
  validates_format_of :zipcode, :with => /\A\d{5}-\d{4}|\A\d{5}\z/, :message => "should be in the form 12345 or 12345-1234"
  geocoded_by :zipcode
  before_validation :geocode

  def converted_date
    DateTime.parse(self.run_date)
  end

  def run_hours
  end

  def run_minutes
  end

  def run_daypart
  end

  def self.run_history(user)
    Run.where(runner: user).or(Run.where(companion: user)).order('run_date ASC')
  end

  def self.past_runs(runs)
    runs.select { |run| run.converted_date < DateTime.now }
  end

  def self.upcoming_runs(runs)
    runs.select { |run| run.converted_date > DateTime.now }
  end

  def self.nearby_runs(run)
    Run.near([run.latitude, run.longitude],1,:order => :distance)
  end

  def self.runs_on_date(searched_run, runs)
    runs.where(run_date: searched_run.run_date)
  end

  def self.runs_by_experience(available_runs, user)
    available_runs.joins(runner: :profile).where(profile: { experience: user.profile.experience })
  end

  def self.search_results(my_available_runs, user)
    my_available_runs.where(companion_id: nil).where.not(runner: user)
  end

end
