# Stew

[![Code Climate](https://codeclimate.com/github/mskog/stew.png)](https://codeclimate.com/github/mskog/stew)

##Information

In constant development. Can and will completely break between updates. Do not use for anything serious.
Will be released as a gem the second it is ready

##Getting started
This information can and will change at any time. Only use this if you want to play around with it

###Steam Community
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

#####Profile
```ruby
steam_id.profile.nickname
=> 'Best baunty EU'
```

#####Games
```ruby
steam_id.games.each {|game| puts game.name}
```

##Lots more to come
