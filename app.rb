require 'sinatra/base'
require 'dotenv'
Dotenv.load
require './lib/github_pull_request'
require 'json'

class GDSGithubPivotal < Sinatra::Base

  post '/payload' do
    status 204
    body ''
    pivotal_poster = PivotalPoster.new
    payload = JSON.parse(request.body.read)
    GitHubPullRequest.new(payload["repository"]["id"],payload["number"],pivotal_poster)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
