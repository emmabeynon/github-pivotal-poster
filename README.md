# GitHub-Pivotal-Poster

This app uses GitHub webhooks to be notified when a Pull Request is opened or changed on GitHub.  When it finds a link to a Pivotal Tracker story in the Pull Request, it posts a link to that Pull Request in a note to the story it finds.  This is an extension to the GitHub-Trello-Poster

## User Stories
```
As a Digital Marketplace developer

So that I can make sure that the Pivotal Tracker story I am working on has the correct PR information

I would like a link to relevant PRs to be automatically added to the Trello card.

```

## Technical Documentation
This app is built using Ruby and Sinatra.  It makes use of GitHub webhooks to receive pull request information, and the Pivotal Tracker API to post pull request information to Pivotal Tracker stories.

#### Setting up the app
1. Clone the repo down to your local machine.
2. Run `bundle install`.
3. Get your [GitHub access token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) and assign to the `GITHUB_ACCESS_TOKEN` environment variable.
4. Assign your Pivotal Tracker Username to the `PIVOTAL_USERNAME` environment variable.
5. Assign your Pivotal Tracker password to the `PIVOTAL_PASSWORD` environment variable.
6. To set up a Webook:
  -  Navigate to your chosen organisation or repository's settings on GitHub. Select 'Webhooks' and click 'Add webhook'  
  - Paste your payload URL (i.e. 'https://[inster-your-site-here]/payload') in the Payload URL box.
  - Select content type as application/json.
  - Select 'Let me select individual events' and check the 'Pull requests' box.
  - Leave the Active checkbox checked, and save.
7. Deploy to your preferred platform, or to run locally, run `ruby app.rb`.  If running locally, I would recommend using [ngrok](https://github.com/inconshreveable/ngrok) to create a secure tunnel from the webhook payload to your localhost.

#### Running the test suite
Run `bundle exec rspec`.
