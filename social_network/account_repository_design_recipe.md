# Account Model and Repository Classes Design Recipe

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: accounts

# Model class
# (in lib/account.rb)
class Account
end

# Repository class
# (in lib/account_repository.rb)
class AccountRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: accounts

# Model class
# (in lib/account.rb)

class Account

  # Replace the attributes by your own columns.
  attr_accessor :id, :email, :username, :post 
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: accounts

# Repository class
# (in lib/account_repository.rb)

class AccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email, username, post FROM accounts;

    # Returns an array of Account objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, email, username, post FROM accounts WHERE id = $1;

    # Returns a single Account object.
  end

  # Add more methods below for each operation you'd like to implement.

  # Adds new record in to the 'posts' table
  # One argument: the new post
  def create(new_account)
    # Executes the SQL query:
    # INSERT INTO accounts (email, username, post) VALUES (4, 'test4@email.com', 'username4', 'post4')

    # Returns nothing
  end

  # Deletes a posts
  # One argument: the id (number)
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM accounts WHERE id = $1

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
# Get all accounts
repo = AccountRepository.new

accounts = repo.all

accounts.length # =>  3

accounts[0].id # =>  1
accounts[0].email # =>  'test1@email.com'
accounts[0].username # =>  'username1'
accounts[0].post # => post1

accounts[1].id # =>  2
accounts[1].email # =>  'test2@email.com'
accounts[1].username # =>  'username2'
accounts[1].post # => post2

accounts[2].id # =>  3
accounts[2].email # =>  'test3@email.com'
accounts[2].username # =>  'username3'
accounts[2].post # => post3

# 2
# Get a single account
repo = AccountRepository.new

account = repo.find(1)

accounts.id # =>  1
accounts.email # =>  'test1@email.com'
accounts.username # =>  'username1'
accounts.post # => post1

# Add more examples for each method

# 3
# Adds new record to the 'accounts' table
repo = AccountRepository.new

new_account = Account.new
new_account.id # => 4
new_account.email # => "test4@email.com"
new_account.username # => "username4"
new_account.post # => post4
repo.create(new_account)
all_accounts = repo.all
all_accounts.length # => 4

# 4
# Deletes an account
repo = AccountsRepistory.new
repo.delete(4)
all_accounts = repo.all
all_accounts.length # => 3


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/account_repository_spec.rb

def reset_accounts_table
  seed_sql = File.read('spec/seeds_social_network.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe AccountRepository do
  before(:each) do 
    reset_accounts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

