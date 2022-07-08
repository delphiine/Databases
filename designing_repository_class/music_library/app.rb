require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

class Application
  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(music_library, io, album_repository, artist_repository)
    DatabaseConnection.connect(music_library)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts "Welcome to the music library manager!"
    puts " "
    @io.puts "What would you like to do?  
    1 - List all albums   
    2 - List all artists"
    puts " "
    @io.puts"Enter your choice: "
    answer = @io.gets.chomp

    num = 1
    if answer == "1" 
        @album_repository.all.each do |record|
            puts "* #{num} - #{record.title}"
            num += 1
        end
    else 
        @artist_repository.all.each do |item|
            puts "* #{num} - #{item.name}"
            num += 1 
        end
    end

    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.
  end
end

# If we run this file using `ruby app.rb`,
# run the app.
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end