require "artist_repository"

describe ArtistRepository do
  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test'})
    connection.exec(seed_sql)
    DatabaseConnection.connect("music_library_test")
  end

  before(:each) do
    reset_artists_table
  end

  it "returns the number of available artists" do
    repo = ArtistRepository.new
    artists = repo.all
    expect(artists.length).to eq 2
  end

  it 'creates new artist' do
    repository = ArtistRepository.new

    new_artist = Artist.new
    new_artist.id = 3
    new_artist.name = 'Pixies'
    new_artist.genre = 'Alternative'

    repository.create(new_artist)

    all_artists = repository.all
    expect(all_artists).to include(
        have_attributes(name: new_artist.name, genre: new_artist.genre)
    )
  end
end