require 'pivotal-tracker'

class PivotalPoster
  attr_reader :client

  def initialize
    @client = authenticate
  end

  def authenticate
    PivotalTracker::Client.token = ENV['PIVOTAL_API_TOKEN']
  end
end
