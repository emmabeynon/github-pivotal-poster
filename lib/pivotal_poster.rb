require 'pivotal-tracker'

class PivotalPoster
  attr_reader :project, :story

  def initialize(api_token)
    PivotalTracker::Client.token = api_token
  end

  def post(project_id, story_id, pr_url)
    @project ||= retrieve_project(project_id)
    @story ||= retrieve_story(story_id)
    post_github_pr_url(pr_url)
  end

  def retrieve_project(project_id)
    PivotalTracker::Project.find(project_id)
  end

  def retrieve_story(story_id)
    project.stories.find(story_id)
  end


private

  def post_github_pr_url(pr_url)
    story.notes.create(text: "#{pr_url}")
  end
end
