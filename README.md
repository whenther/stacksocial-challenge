# twitter-on-rails

## Walkthrough
Brief walkthrough of app design / choices made

For this challenge, I set up a pretty basic Rails 5 app, server-rendered for simplicity.

It uses a basic `bcrypt` setup for users and authentication, and checks for a logged-in user for protecting the tweet routes.

For caching responses, the app writes a requested twitter handle to the database when it's requested for the first time. Then it fetches the tweets, and saves those with the forign key for the cached handle. When a second request comes in for that handle, the app looks to see if that handle has been saved in the last five minutes. If it has, it looks up the tweets in the `tweets` table. Otherwise, it requests and chaches new ones. In a real production system, it might make sense to clear out the cache from time to time, though maybe only after archiving the old data, if it was useful for analytics.

Probably the trickiest part of the app was just getting the Twitter oauth setup to work. Luckily, reading public tweets doesn't require a user key, just an application one, so it didn't need to connect to the user's account.

## Development Setup
Add a `.env` file with the twitter credentials:
```
TWITTER_KEY=KEYHERE
TWITTER_SECRET=SECRETHERE
```

Create and migrate database
```
bin/rails db:create
bin/rails db:migrate
```

Run the server
```
bin/rails server
```

open `localhost:3000`

## Deployment
Push to heroku
```
git push heroku master
```

Create and migrate database
```
heroku run rake db:create
heroku run rake db:migrate
```

Set environment variables
```
heroku config:set TWITTER_KEY=KEYHERE
heroku config:set TWITTER_SECRET=SECRETHERE
```

## Test
```
rake test
```
