require_relative('../db/sql_runner')

class Album

  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
 end

 def save()
 sql = "INSERT INTO albums
 (
 title,
 genre,
 artist_id
)
VALUES
(
  $1, $2, $3
)
RETURNING id"
values = [@title, @genre, @artist_id]
@id = SqlRunner.run(sql, values)[0]['id'].to_i
end

def self.delete_all()
  sql = "DELETE FROM albums"
  SqlRunner.run(sql)
end

def self.all()
  sql= "SELECT * FROM albums"
  orders = SqlRunner.run(sql)
  return orders.map { |order| Album.new(order)}
end

def artist()
sql = " SELECT * FROM artists WHERE id = $1"
values = [artist_id]
results = SqlRunner.run(sql, values)
artist_hash = results.first
artist = Artist.new(artist_hash)
return artist
end

def update()
  sql = "UPDATE albums SET
  (
  title,
  genre,
  artist_id
  ) =
  (
  $1, $2, $3
  )
  WHERE id = $4"
  values = [@title, @genre, @artist_id, @id]
  SqlRunner.run(sql, values)
end

def self.find(id)
  sql = "SELECT * FROM albums WHERE id = $1"
  values = [id]
  results = SqlRunner.run(sql, values)
  find_hash = results.first
  find = Album.new(find_hash)
  return find
end

end
