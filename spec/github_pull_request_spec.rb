require 'github_pull_request'
require 'ostruct'

describe GitHubPullRequest do
  let(:pivotal_poster) { double(PivotalPoster) }
  let(:repo_pull_request) do
    OpenStruct.new({
      html_url: 'https://github.com/gov-test-org/project-b/pull/1',
      body: 'A commit with a PivotalTracker URL https://www.pivotaltracker.com/story/show/128659665'
    })
  end
  let(:octokit) { double Octokit::Client, login: 'username', pull_request: repo_pull_request }
  subject(:github_pr) { GitHubPullRequest.new(60356369, 1, pivotal_poster) }

  before(:each) do
    allow(Octokit::Client).to receive(:new).and_return(octokit)
    allow(pivotal_poster).to receive(:post)
  end

  describe 'Default' do
    it 'initializes with login_user set to an authenticated Github user' do
      expect(github_pr.login_user).to have_attributes(login: 'username')
    end

  end

  describe '#fetch_pull_request_data' do
    it 'retrieves HTML URL and body data for the given URL and passes to the check_for_trello_card method, leading to GitHubPullRequest being instantiated' do
      expect(pivotal_poster).to receive(:post).with(1788875, 128659665, 'https://github.com/gov-test-org/project-b/pull/1')
      GitHubPullRequest.new(60356369, 1, pivotal_poster)
    end
  end
end
