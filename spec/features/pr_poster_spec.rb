require 'github_pull_request'

describe 'Pull Request Poster' do

  it 'posts a pull request URL to the Trello card referenced in its commit message' do
    pivotal_poster = PivotalPoster.new(ENV['PIVOTAL_API_TOKEN'])
    github_pr = GitHubPullRequest.new(60356290, 4, pivotal_poster)
    pull_request = github_pr.login_user.pull_request(60356290, 4)
    PivotalTracker::Client.token = ENV['PIVOTAL_API_TOKEN']
    project = PivotalTracker::Project.find(1788875)
    story = project.stories.find(128659665)
    expect(story.notes.all.first.text).to eq(pull_request.html_url)
    story.notes.all.delete(story.notes.all.first)
  end

  xit 'does not post a pull request URL to a Trello card if it already exists in the card\'s PR checklist' do
    GitHubPullRequest.new(60356290, 1, pivotal_poster)
    expect(@checklist.check_items.count).to eq(1)
  end
end
