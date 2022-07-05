require_relative './artist'
require_relative 'database_connection'
require 'pg'

class ArtistRepository
  def all
    artists = []
    sql = 'SELECT id, name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      artist = Artist.new
      artist.id = record['id'].to_i
      artist.name = record['name']
      artist.genre = record['genre']
      artists << artist
    end
    return artists
  end

  def find(id)
    param = [id]
    sql = 'SELECT * FROM artists WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, param)

    result = result_set[0]
    artist = Artist.new
    artist.id = result['id'].to_i
    artist.name = result['name']
    artist.genre = result['genre']

    return artist
  end
end