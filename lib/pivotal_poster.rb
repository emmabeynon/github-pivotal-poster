require 'pivotal-tracker'

class PivotalPoster
  attr_reader :client, :project

  def initialize(project_id)
    @client = authenticate
    @project = retrieve_project(project_id)
  end

  def retrieve_project(project_id)
    PivotalTracker::Project.find(project_id)
  end

private

  def authenticate
    PivotalTracker::Client.token = ENV['PIVOTAL_API_TOKEN']
  end
end
