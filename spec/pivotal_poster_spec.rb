require 'pivotal_poster'

describe PivotalPoster do
  let(:pivotal_poster) { PivotalPoster.new(ENV['PIVOTAL_API_TOKEN']) }

  let(:pivotal_project) do
    double("PivotalTracker::Project",
            id: 1788875,
            stories: [])
  end

  let(:pivotal_story) do
    double("PivotalTracker::Story",
            id: 128659665,
            notes: double("PivotalTracker::Note", create: story_note))
  end

  let(:story_note) { double("PivotalTracker::Note") }

  before(:each) do
    allow(PivotalTracker::Project).to receive(:find).with(1788875).and_return(pivotal_project)
    allow(pivotal_project.stories).to receive(:find).with(128659665).and_return(pivotal_story)
    pivotal_poster.post(1788875, 128659665, 'https://github.com/gov-test-org/project-b/pull/1')
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
end
