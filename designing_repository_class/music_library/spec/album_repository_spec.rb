require "album_repository"

describe AlbumRepository do
    def reset_albums_table
        seed_sql = File.read('spec/seeds_albums.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_albums_table
    end

    it 'returns all albums' do
        repo = AlbumRepository.new
        albums = repo.all

        expect(albums.length).to eq(2)
        
        expect(albums[0].title).to eq('Here Comes the Sun')
        expect(albums[0].release_year).to eq('1971')
        expect(albums[0].artist_id).to eq('1')
    
        expect(albums[1].title).to eq('Waterloo')
        expect(albums[1].release_year).to eq('1972')
        expect(albums[1].artist_id).to eq('2')
    end

    it 'creates new album' do
        repository = AlbumRepository.new

        new_album = Album.new
        new_album.title = 'Trompe le Monde'
        new_album.release_year = '1991'
        new_album.artist_id = '1'

        repository.create(new_album)

        all_albums = repository.all
        expect(all_albums).to include(
            have_attributes(title: new_album.title, release_year: new_album.release_year, artist_id: new_album.artist_id)
        )
    end
end