# RapidAPIConnect_Ruby
Use RapidAPI blocks from your Ruby app.

Include gem:
```
gem 'rapid_connect'
```

Make connection:
```
connection = RapidConnect.new('rapid_project', 'rapid_token')
response = connection.call('Github', 'getUserStarredRepositories', {
  accessToken: 'access_token',
  user: 'twitter',
  page: '1',
  perPage: '10'
})
```