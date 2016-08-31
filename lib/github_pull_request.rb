require 'octokit'
require_relative 'pivotal_poster'
require 'net/http'

class GitHubPullRequest
  attr_reader :login_user, :pivotal_poster

  def initialize(repo, pull_request_id, pivotal_poster)
    @login_user = authenticate
    @pivotal_poster = pivotal_poster
    fetch_pull_request_data(repo, pull_request_id)
  end

  def fetch_pull_request_data(repo, pull_request_id)
    pull_request = login_user.pull_request(repo, pull_request_id)
    unless pull_request.body.empty?
      check_for_pivotal_story(pull_request.html_url, pull_request.body)
    end
  end

private

  def authenticate
    @login_user = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
  end

  def check_for_pivotal_story(pr_url, pr_body)
    pivotal_story_url = pr_body.match(%r{https://www.pivotaltracker.com/story/show/\w{9}})
    if pivotal_story_url
      full_pivotal_url = get_full_pivotal_url(pivotal_story_url)
      ids = extract_ids(full_pivotal_url)
      post_to_pivotal(ids[-3].to_i, ids[-1].to_i, pr_url)
    end
  end

  def extract_ids(pivotal_url)
    pivotal_url.split('/')
  end

  def get_full_pivotal_url(url)
    uri = URI(url[0])
    res = Net::HTTP.get_response(uri)
    res['location']
  end

  def post_to_pivotal(project_id, story_id, pr_url)
    pivotal_poster.post(project_id, story_id, pr_url)
  end
end
