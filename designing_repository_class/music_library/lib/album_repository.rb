require_relative './album'
require_relative 'database_connection'
require 'pg'

class AlbumRepository
    def all
        albums = []
        sql = 'SELECT id, title, release_year, artist_id FROM albums'
        result_set = DatabaseConnection.exec_params(sql, [])

        result_set.each do |record|
            album = Album.new
            album.id = record['id'].to_i
            album.title = record['title']
            album.release_year = record['release_year']
            album.artist_id = record['artist_id']
            albums << album
        end

        return albums
    end

    def find(id)
        param = [id]
        sql = 'SELECT * FROM artists WHERE id = $1;'
        result_set = DatabaseConnection.exec_params(sql, param)
    
        result = result_set[0]
        album = Album.new
        album.id = result['id'].to_i
        album.title = result['title']
        album.release_year = result['release_year']
        album.artist_id = result['artist_id']
    
        return album
    end

    def create(album)
        sql = 'INSERT INTO 
                albums (title, release_year, artist_id) 
                VALUES ($1, $2, $3);'
        sql_parms = [album.title, album.release_year, album.artist_id]

        DatabaseConnection.exec_params(sql, sql_parms)

        return nil
    end
end