require 'pivotal_poster'

describe PivotalPoster do
  let(:pivotal_poster) { PivotalPoster.new(1788875, 128659665, 'https://github.com/gov-test-org/project-b/pull/1') }

  let(:pivotal_project) do
    instance_double("PivotalTracker::Project",
                    id: 1788875,
                    stories: [])
  end

  let(:pivotal_story) do
    instance_double("PivotalTracker::Story",
                    id: 128659665,
                    notes: instance_double("PivotalTracker::Note", create: story_note))
  end

  let(:story_note) { instance_double("PivotalTracker::Note") }

  before(:each) do
    allow(PivotalTracker::Project).to receive(:find).with(1788875).and_return(pivotal_project)
    allow(pivotal_project.stories).to receive(:find).with(128659665).and_return(pivotal_story)
    allow(pivotal_story.notes).to receive(:create).and_return(story_note)
  end

  describe '#retrieve_project' do
    it 'retrieves the correct PivotalTracker project' do
      expect(pivotal_poster.project).to eq(pivotal_project)
    end
  end

  describe '#retrieve_story' do
    it 'retrieves the correct PivotalTracker story' do
      expect(pivotal_poster.story).to eq(pivotal_story)
    end
  end

  describe '#post_github_pr_url' do
    xit 'posts a GitHub Pull Request URL to a PivotalTracker story' do
      pivotal_poster.post_github_pr_url
      expect(pivotal_story.notes).to have_received(:create)
    end
  end
end
