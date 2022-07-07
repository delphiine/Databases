# Post Model and Repository Classes Design Recipe

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.


## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: accounts

# Model class
# (in lib/post.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views, :account_id 
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, views, account_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, views, account_id FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  # Add more methods below for each operation you'd like to implement.

  # Adds new record to the 'posts' table
  # One argument: the new post
  def create(new_post)
    # Executes the SQL query:
    # INSERT INTO posts (id, title, content, views, account_id) VALUES (4, 'title4', 'content4', 2, 1);

    # Returns nothing
  end

  # Deletes a posts
  # One argument: the id (number)
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1

    # Returns nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all posts

repo = PostRepository.new

posts = repo.all

posts.length # =>  3

posts[0].id # =>  1
posts[0].title # =>  'title1'
posts[0].content # =>  'content1'
posts[0].views # => 3
posts[0].account_id # => 1

posts[1].id # =>  2
posts[1].title # =>  'title2'
posts[1].content # =>  'content2'
posts[1].views # => 7
posts[1].account_id # => 1

posts[2].id # =>  3
posts[2].title # =>  'title3'
posts[2].content # =>  'content3'
posts[2].views # => 7
posts[2].account_id # => 1

# 2
# Get a single post

repo = PostRepository.new

post = repo.find(2)

posts.id # =>  2
posts.title # =>  'title2'
posts.content # =>  'content2'
posts.vews # => 7
posts.account_id # => 1


# Add more examples for each method

# 3
# Adds new record in to the 'posts' table
repo = PostRepository.new

new_post = Post.new
new_post.id # => 4
new_post.title # => "title4"
new_post.content # => "content4"
new_post.views # => 2
new_post.account_id # => 1
repo.create(new_post)
all_posts = repo.all
all_posts.length # => 4

# 4
# Deletes a posts
repo = PostRepository.new
repo.delete(4)
all_posts = repo.all
all_posts.length # => 3


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/post_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_social_network.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

