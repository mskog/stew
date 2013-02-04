# Stew

[![Code Climate](https://codeclimate.com/github/mskog/stew.png)](https://codeclimate.com/github/mskog/stew)

##Information

Stew can access both the Steam Community and the Steam Store. The Community library uses the Steam XML API and should be rather stable.
The Store library accesses the Store pages by parsing the HTML. This should be considered unstable and you have to be prepared for missing data in case the store pages change.

###Steam Community
The Community part of the API is a work in progress and lacks a lot of the fields expected in for example a Profile.
You can however still use it to retrieve the games for a profile and such.

####Create a Steam ID
```ruby
steam_id = Stew::Community::SteamId.create("http://steamcommunity.com/profiles/76561197992917668")
```

You can also use the 64 bit ids. This is equivalent to above:
```ruby
steam_id = Stew::Community::SteamId.create(76561197992917668)
```

Finally, you can use vanity names or URLs to create steam_ids like so:

```ruby
steam_id = Stew::Community::SteamId.create("http://steamcommunity.com/id/eekon20")
```
or
```ruby
steam_id = Stew::Community::SteamId.create("eekon20")
```

Once you have created a Steam ID, you can use it to get information like the Profile, Games and Friends

##### Profile
```ruby
steam_id.profile.nickname #=> 'Best baunty EU'
```

##### Games
```ruby
steam_id.games.each {|game| puts game.name}
```

##### Friends
```ruby
steam_id.friends.each {|friend| puts friend.profile.nickname}
```


## Store
**Important! The Store library accesses the Store pages by parsing HTML responses. It will give nil values in case the HTML on the store pages change**

#### Create a Store Application

##### From an App id
```ruby
app = Stew::StoreClient.new.create_app(220240)
```

##### From a URL
```ruby
app = Stew::StoreClient.new.create_app("http://store.steampowered.com/app/220240/")
```

##### From a URL with a region
```ruby
app = Stew::StoreClient.new.create_app("http://store.steampowered.com/app/220240/?cc=uk")
```

All the examples above will create a Stew::Store::App instance for the game Far Cry 3. You can then access data like so:

```ruby
app.name #=> "Far Cry 3"

app.score #=> 88 #Metacritic score

app.release_date.to_s #=> "2012-12-04"

app.price #=> Money instance. https://github.com/RubyMoney/money

app.offers #=> AppOffers

app.offers.sale? #=> false

app.indie? #=> false

app.free? #=> false :(
```

More data is available for apps and app offers. See the code for the specific classes to find out.

## Contribute

Will gladly accept pull requests.

