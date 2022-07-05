require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Perform a SQL query on the database and get the result set.
album_repository = AlbumRepository.new
artist_repository = ArtistRepository.new

# Print out each record from the result set .

album_repository.each do |album|
  p album.title
end

artist_repository.each do |artist|
  p artist
end