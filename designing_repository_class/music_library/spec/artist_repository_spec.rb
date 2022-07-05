require "artist_repository"

def reset_artists_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library'})
  connection.exec(seed_sql)
end

describe ArtistRepository do
  before(:each) do
    reset_artists_table
  end

  it "returns the number of available artists" do
    repo = ArtistRepository.new
    artists = repo.all
    expect(artists.length).to eq 4
  end
end