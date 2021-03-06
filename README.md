# Stew

[![Gem Version](https://badge.fury.io/rb/stew.png)](http://badge.fury.io/rb/stew)
[![Code Climate](https://codeclimate.com/github/mskog/stew.png)](https://codeclimate.com/github/mskog/stew)
[![Dependency Status](https://gemnasium.com/mskog/stew.png)](https://gemnasium.com/mskog/stew)

##Important!

**Steam has deprecated their old xml format api. The good news is that they have added the remaining functionality from it to their "real" web api.
From version 0.6.0, Stew no longer supports the old, deprecated, api. From this version you need a Steam Web API Key to use Stew**

##Information

This is used in production at http://www.gamemagus.com

Stew can access both the Steam Community and the Steam Store. The Community library uses the Steam Web API and should be rather stable.
The Store library accesses the Store pages by parsing the HTML. This should be considered unstable and you have to be prepared for missing data in case the store pages change.

###Steam Community
The Community part of the API is a work in progress and lacks a lot of the fields expected in for example a Profile.
You can however still use it to retrieve the games for a profile and such.

####Before Use
You need to retrieve and set your Steam Web API key before using Stew. If you don't have one, then one can be found here: http://steamcommunity.com/dev/apikey

Once you have a key, make Stew use it:

```ruby
Stew.configure(steam_api_key: YOURKEY)
```

####Create a Steam ID
```ruby
steam_id = Stew::Community::SteamId.new("http://steamcommunity.com/profiles/76561197992917668")
```

You can also use the 64 bit ids. This is equivalent to above:
```ruby
steam_id = Stew::Community::SteamId.new(76561197992917668)
```

Finally, you can use vanity names or URLs to create steam_ids like so:

```ruby
steam_id = Stew::Community::SteamId.new("http://steamcommunity.com/id/eekon20")
```
or
```ruby
steam_id = Stew::Community::SteamId.new("eekon20")
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
app = Stew::Store::StoreClient.new.app(220240)
```

##### From an App id in a specific region
A more robust region support, with region identification by country etc, is planned.
```ruby
app = Stew::Store::StoreClient.new.app(220240, :uk)
```

##### From a URL
```ruby
app = Stew::Store::StoreClient.new.create_app("http://store.steampowered.com/app/220240/")
```

##### From a URL with a region
```ruby
app = Stew::Store::StoreClient.new.create_app("http://store.steampowered.com/app/220240/?cc=uk")
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
You will need a Steam Web API key to contribute to this project. The key is set in the spec/config.yml file. See the example
Will gladly accept pull requests.

