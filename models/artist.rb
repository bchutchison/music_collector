require_relative('../db/sql_runner')

class Artist

attr_accessor :name
attr_reader :id

  def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
 end

def save()
  sql = "INSERT INTO artists ( name )
  VALUES ($1)
  RETURNING id"
  values = [@name]
  @id = SqlRunner.run(sql, values)[0][ 'id'].to_i
end

def self.delete_all()
  sql = "DELETE FROM artists"
  SqlRunner.run(sql)
end

def self.all()
  sql= "SELECT * FROM artists"
  orders = SqlRunner.run(sql)
  return orders.map { |order| Artist.new(order)}
end

def album_list
  sql = "SELECT * FROM albums WHERE artist_id = $1"
  values = [@id]
  album_list_hashes = SqlRunner.run(sql, values)
  album_list = album_list_hashes.map { |order|
  Album.new (order) }
  return album_list
end

def update()
  sql = "UPDATE artists SET name = $1 WHERE id = $2"
  values = [@name, @id]
  SqlRunner.run(sql, values)
end

def self.find(id)
  sql = "SELECT * FROM artists WHERE id = $1"
  values = [id]
  results = SqlRunner.run(sql, values)
  find_hash = results.first
  find = Artist.new(find_hash)
  return find
end



end
