require 'pivotal-tracker'

class PivotalPoster
  attr_reader :project, :story

  def initialize(project_id, story_id)
    authenticate
    @project = retrieve_project(project_id)
    @story = retrieve_story(story_id)
  end

  def retrieve_project(project_id)
    PivotalTracker::Project.find(project_id)
  end

  def retrieve_story(story_id)
    project.stories.find(story_id)
  end

private

  def authenticate
    PivotalTracker::Client.token = ENV['PIVOTAL_API_TOKEN']
  end
end
