require 'pivotal_poster'

describe PivotalPoster do
  let(:pivotal_poster) { PivotalPoster.new(1788875, 128659665) }
  let(:pivotal_project) do
    instance_double("PivotalTracker::Project",
                    id: 1788875,
                    stories: [])
  end
  let(:pivotal_story) { instance_double("PivotalTracker::Story", id: 128659665) }

  before(:each) do
    allow(PivotalTracker::Project).to receive(:find).with(1788875).and_return(pivotal_project)
    allow(pivotal_project.stories).to receive(:find).with(128659665).and_return(pivotal_story)
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
