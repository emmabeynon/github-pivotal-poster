require 'pivotal_poster'

describe PivotalPoster do
  let(:pivotal_poster) { PivotalPoster.new }

  describe '#authenticate' do
    it 'authenticates a PivotalTracker client' do
      expect(pivotal_poster.client).not_to be nil
    end
  end
end
