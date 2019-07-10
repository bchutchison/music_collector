require("pry")
require_relative('../models/album')
require_relative('../models/artist')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new( {'name' => 'Bjork'})
artist1.save()

album1 = Album.new({
  'title' => 'Vespertine',
  'genre' => 'Avant-Garde',
  'artist_id' => artist1.id
  })
  album1.save()

album2 = Album.new({
  'title' => 'Vespertine2',
  'genre' => 'Avant-Garde2',
  'artist_id' => artist1.id
  })
  album2.save()

binding.pry
nil
