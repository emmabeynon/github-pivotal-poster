require 'pivotal_poster'

describe PivotalPoster do
  let(:pivotal_poster) { PivotalPoster.new(1788875) }
  let(:pivotal_project) do
    instance_double("PivotalTracker::Project", id: 1788875, name: "Test project")
  end

  before(:each) do
    allow(PivotalTracker::Project).to receive(:find).and_return(pivotal_project)
  end

  describe '#retrieve_project' do
    it 'retrieves the correct PivotalTracker project' do
      expect(pivotal_poster.project).to eq(pivotal_project)
    end
  end
end
