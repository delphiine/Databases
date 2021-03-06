require_relative './album'

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

    def create(new_album)
        sql = 'INSERT INTO 
                albums (id, title, release_year, artist_id) 
                VALUES ($1, $2, $3, $4);'
        params = [new_album.id, new_album.title, new_album.release_year, new_album.artist_id]

        DatabaseConnection.exec_params(sql, params)

        return nil
    end
end