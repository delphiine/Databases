require_relative './book'

class BookRepository
    def all
        # Executes the SQL query:
        sql = 'SELECT id, title, author_name FROM books'
        result_set = DatabaseConnection.exec_params(sql, [])
        books = []
        
        result_set.each do |item|
            book = Book.new
            book.id = item['id'].to_i
            book.title = item['title']
            book.author_name = item['author_name']
            books << book
        end
        # Returns an array of Book objects.
        return books
    end

    def find(id)
        sql = 'SELECT id, title, author_name FROM books WHERE id = $1'
        result_set = DatabaseConnection.exec_params(sql, [id])

        item = result_set[0]
        book = Book.new
        book.id = item['id'].to_i
        book.title = item['title']
        book.author_name = item['author_name']

        # Returns 1 Book objects.
        return book
    end
end