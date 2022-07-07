
1. Design and create the Table
If the table is already created in the database, you can skip this step.

2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.
```
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE albums RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year, artist_id) VALUES ('Here Comes the Sun', 1971, 4);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Waterloo', 1972, 2);
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.
```

psql -h 127.0.0.1 music_library < seeds_albums.sql
3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.
```
# EXAMPLE
# Table name: albums

# Model class
# (in lib/album.rb)
class Album
end

# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
end
4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: albums

# Model class
# (in lib/albums.rb)

class Album

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :release_year, :artist_id
end
```
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.
```
# EXAMPLE
# Table name: Albums

# Repository class
# (in lib/album_repository.rb)

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library' })
    result = connection.exec_params('SELECT id, title, release_year, artist_id FROM albums', [])
    result.each
    # transform result (list of dictionaries?) into list of Album objects

    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;

    # Returns an array of Album objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;

    # Returns a single Album object.
  end

  # Create new records into a table
  # No arguments
  def create(album)
    # Executes the SQL query:
    # INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);

    # Returns nothing
  end
```
6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.
```
# EXAMPLES

# 1
# Get all albums

repo = AlbumRepository.new

albums = repo.all

albums.length # =>  4

albums[0].id # =>  1
albums[0].title # =>  'Here Comes the Sun'
albums[0].release_year # =>  1971
albums[0].artist_id # => 3

albums[1].id # =>  2
albums[1].title # =>  'Waterloo'
albums[1].release_year # =>  1972
albums[1].artist_id # => 3

# 2
# Get a single album

repo = AlbumRepository.new

albums = repo.find(1)

albums.artist_id # =>  3
albums.title # =>  'Here Comes the Sun'
albums.release_year # =>  1971
albums.id # => 1


# 3
# Create new records into a table
repository = AlbumRepository.new

album = Album.new
album.title = 'Trompe le Monde'
album.release_year = 1991
album.artist_id = 1

repository.create(album)

all_albums = repository.all

```

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.
```
# EXAMPLE

# file: spec/album_repository_spec.rb

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end
    
end
```
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.