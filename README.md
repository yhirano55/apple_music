# AppleMusic

This is a ruby wrapper for the [Apple Music API](https://developer.apple.com/documentation/applemusicapi).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apple_music'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apple_music

## Usage

AppleMusic gem was designed with usability as its primary goal:

#### e.g. Search Artists

```ruby
artist = AppleMusic::Artist.search('Men I Trust').first # AppleMusic::Artist object
artist.genre_names # ['Electronic']
artist.id # "886240553"
albums = AppleMusic::Artist.related_albums(886240553).map(&:name) # ["Oncle Jazz", "Headroom"...
```

#### e.g. Search Albums

```ruby
albums = AppleMusic::Album.search('BILL EVANS') # AppleMusic::Album object
tracks = AppleMusic::Album.related_tracks(albums[0].id)
tracks.first.name # "Waltz for Debby"
```

#### e.g. Search Songs

```ruby
songs = AppleMusic::Song.search('Document', storefront: :jp) # AppleMusic::Song object
songs[0].artist_name # "TENDRE"
songs[0].album_name # "NOT IN ALMIGHTY"
```

## Features

Currently, it work in progress, so it can use apis which does not need user token.

### Albums

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get a Catalog Album | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_album) | [:octocat:](#) |
| Get a Catalog Album's Relationship Directly by Name | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_album_s_relationship_directly_by_name) | [:octocat:](#) |
| Get Multiple Catalog Albums | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_albums) | [:octocat:](#) |
| Get Multiple Catalog Albums by UPC | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_albums_by_upc) | [:octocat:](#) |
| Get a Library Album | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_library_album) | |
| Get a Library Album's Relationship Directly by Name | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_library_album_s_relationship_directly_by_name) | |
| Get Multiple Library Albums | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_library_albums) | |
| Get All Library Albums | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_all_library_albums) | |

### Artists

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get a Catalog Artist | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_artist) | [:octocat:](#) |
| Get Multiple Catalog Artists | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_artists) | [:octocat:](#) |
| Get a Catalog Artist's Relationship Directly by Name | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_artist_s_relationship_directly_by_name) | [:octocat:](#) |
| Get a Library Artist | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_library_artist) | |
| Get All Library Artists | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_all_library_artists) | |
| Get Multiple Library Artists | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_library_artists) | |
| Get a Library Artist's Relationship Directly by Name | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_library_artist_s_relationship_directly_by_name) | |

### Songs

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get a Catalog Song | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_song) | [:octocat:](#) |
| Get Multiple Catalog Songs by ID | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_songs_by_id) | [:octocat:](#) |
| Get Multiple Catalog Songs by ISRC | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_songs_by_isrc) | [:octocat:](#) |
| Get a Catalog Song's Relationship Directly by Name | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_song_s_relationship_directly_by_name) | [:octocat:](#) |
| Get a Library Song | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_library_song) | |
| Get All Library Songs | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_all_library_songs) | |
| Get Multiple Library Songs | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_library_songs) | |
| Get a Library Song's Relationship Directly by Name | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_library_song_s_relationship_directly_by_name) | |

### Music Videos

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get a Catalog Music Video | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_music_video) | [:octocat:](#) |
| Get a Catalog Music Video's Relationship Directly by Name | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_music_video_s_relationship_directly_by_name) | [:octocat:](#) |
| Get Multiple Catalog Music Videos by ID | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_music_videos_by_id) | [:octocat:](#) |
| Get Multiple Catalog Music Videos by ISRC | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_music_videos_by_isrc) | [:octocat:](#) |
| Get a Library Music Video | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_library_music_video) | |
| Get a Library Music Video's Relationship Directly by Name | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_library_music_video_s_relationship_directly_by_name) | |
| Get Multiple Library Music Videos | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_library_music_videos) | |
| Get All Library Music Videos | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_all_library_music_videos) | |

### Playlists

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get a Catalog Playlist | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_playlist) | [:octocat:](#) |
| Get a Catalog Playlist's Relationship Directly by Name | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_playlist_s_relationship_directly_by_name) | [:octocat:](#) |
| Get Multiple Catalog Playlists | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_playlists) | [:octocat:](#) |
| Get a Library Playlist | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_library_playlist) | |
| Get a Library Playlist's Relationship Directly by Name | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_library_playlist_s_relationship_directly_by_name) | |
| Get Multiple Library Playlists | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_library_playlists) | |
| Get All Library Playlists | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_all_library_playlists) | |

### Apple Music Stations

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get a Catalog Station | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_station) | [:octocat:](#) |
| Get Multiple Catalog Stations | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_stations) | [:octocat:](#) |

### Search

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Search for Catalog Resources | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/search_for_catalog_resources) | [:octocat:](#) |
| Get Catalog Search Hints | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_catalog_search_hints) | [:octocat:](#) |
| Search for Library Resources | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/search_for_library_resources) | |

### Ratings

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get a Personal Album Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_personal_album_rating) | |
| Get a Personal Music Video Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_personal_music_video_rating) | |
| Get a Personal Playlist Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_personal_playlist_rating) | |
| Get a Personal Song Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_personal_song_rating) | |
| Get a Personal Station Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_personal_station_rating) | |
| Get Multiple Personal Album Ratings | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_personal_album_ratings) | |
| Get Multiple Personal Music Video Ratings | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_personal_music_video_ratings) | |
| Get Multiple Personal Playlist Ratings | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_personal_playlist_ratings) | |
| Get Multiple Personal Song Ratings | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_personal_song_ratings) | |
| Get Multiple Personal Station Ratings | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_personal_station_ratings) | |
| Add a Personal Album Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/add_a_personal_album_rating) | |
| Add a Personal Music Video Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/add_a_personal_music_video_rating) | |
| Add a Personal Playlist Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/add_a_personal_playlist_rating) | |
| Add a Personal Song Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/add_a_personal_song_rating) | |
| Add a Personal Station Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/add_a_personal_station_rating) | |
| Delete a Personal Album Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/delete_a_personal_album_rating) | |
| Delete a Personal Music Video Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/delete_a_personal_music_video_rating) | |
| Delete a Personal Playlist Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/delete_a_personal_playlist_rating) | |
| Delete a Personal Song Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/delete_a_personal_song_rating) | |
| Delete a Personal Station Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/delete_a_personal_station_rating) | |
| Get a Personal Library Music Video Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_personal_library_music_video_rating) | |
| Get a Personal Library Playlist Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_personal_library_playlist_rating) | |
| Get a Personal Library Song Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_personal_library_song_rating) | |
| Get Multiple Personal Library Music Video Ratings | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_personal_library_music_video_ratings) | |
| Get Multiple Personal Library Playlist Ratings | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_personal_library_playlist_ratings) | |
| Get Multiple Personal Library Songs Ratings | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_personal_library_songs_ratings) | |
| Add a Personal Library Music Video Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/add_a_personal_library_music_video_rating) | |
| Add a Personal Library Playlist Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/add_a_personal_library_playlist_rating) | |
| Add a Personal Library Song Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/add_a_personal_library_song_rating) | |
| Delete a Personal Library Music Video Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/delete_a_personal_library_music_video_rating) | |
| Delete a Personal Library Playlist Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/delete_a_personal_library_playlist_rating) | |
| Delete a Personal Library Song Rating | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/delete_a_personal_library_song_rating) | |

### Charts

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get Catalog Charts | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_catalog_charts) | [:octocat:](#) |

### Music Genres

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get a Catalog Genre | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_genre) | [:octocat:](#) |
| Get a Catalog Genre's Relationship Directly by Name | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_genre_s_relationship_directly_by_name) | [:octocat:](#) |
| Get Multiple Catalog Genres | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_genres) | [:octocat:](#) |
| Get Catalog Top Charts Genres | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_catalog_top_charts_genres) | [:octocat:](#) |

### Curators

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get a Catalog Curator | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_curator) | [:octocat:](#) |
| Get a Catalog Curator's Relationship Directly by Name | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_curator_s_relationship_directly_by_name) | [:octocat:](#) |
| Get Multiple Catalog Curators | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_curators) | [:octocat:](#) |
| Get a Catalog Apple Curator | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_apple_curator) | |
| Get a Catalog Apple Curator's Relationship Directly by Name | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_apple_curator_s_relationship_directly_by_name) | |
| Get Multiple Catalog Apple Curators | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_apple_curators) | |

### Recommendations

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get a Recommendation | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_recommendation) | |
| Get Multiple Recommendations | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_recommendations) | |
| Get Default Recommendations | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_default_recommendations) | |

### Activities

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get a Catalog Activity | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_activity) | [:octocat:](#) |
| Get a Catalog Activity's Relationship Directly by Name | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_catalog_activity_s_relationship_directly_by_name) | [:octocat:](#) |
| Get Multiple Catalog Activities | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_activities) | [:octocat:](#) |

### History

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get Heavy Rotation Content | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_heavy_rotation_content) | |
| Get Recently Played Resources | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_recently_played_resources) | |
| Get Recently Played Stations | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_recently_played_stations) | |
| Get Recently Added Resources | :no_entry: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_recently_added_resources) | |

### Storefronts and Localization

| Feature | Status | Docs | Code |
|:--------|:------:|:----:|:----:|
| Get a User's Storefront | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_user_s_storefront) | [:octocat:](#) |
| Get a Storefront | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_a_storefront) | [:octocat:](#) |
| Get Multiple Storefronts | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_multiple_storefronts) | [:octocat:](#) |
| Get All Storefronts | :white_check_mark: | [:link:](https://developer.apple.com/documentation/applemusicapi/get_all_storefronts) | [:octocat:](#) |

## Configuration

**NOTE** It's necessary to prepare an `TEAM_ID`, `MUSIC_ID`, and a secret file in advance. Please confirm [Apple Developer Website](https://developer.apple.com/).

It can be set by either an `ENV` variable or an `config/initializers/apple_music.rb`:

```ruby
AppleMusic.configure do |config|
  config.secret_key_path = './AuthKey_MUSIC_ID.p8' # or ENV['APPLE_MUSIC_SECRET_KEY_PATH']
  config.team_id         = 'YOUR TEAM_ID'          # or ENV['APPLE_MUSIC_TEAM_ID']
  config.music_id        = 'YOUR MUSIC_ID'         # or ENV['APPLE_MUSIC_MUSIC_ID']
  config.storefront      = 'jp'                    # or ENV['APPLE_MUSIC_STOREFRONT'] ('us' by default)
end
```

## License

MIT
