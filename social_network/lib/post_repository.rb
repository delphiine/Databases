require_relative './post'

class PostRepository
    def all
        sql = 'SELECT id, title, content, views, account_id FROM posts'
        result_set = DatabaseConnection.exec_params(sql, [])
        posts = []

        result_set.each do |item|
            post = Post.new
            post.id = item['id'].to_i
            post.title = item['title']
            post.content = item['content']
            post.views = item['views'].to_i
            post.account_id = item['account_id'].to_i
            posts << post
        end

        return posts
    end

    def find(id)
        sql = 'SELECT id, title, content, views, account_id FROM posts WHERE id = $1'
        result_set = DatabaseConnection.exec_params(sql, [id])

        item = result_set[0]
        post = Post.new
        post.id = item['id'].to_i
        post.title = item['title']
        post.content = item['content']
        post.views = item['views'].to_i
        post.account_id = item['account_id'].to_i

        return post
    end

    def create(new_post)
       sql = "INSERT INTO 
                posts (id, title, content, views, account_id) 
                VALUES ($1, $2, $3, $4, $5)"
        params = [
            new_post.id,
            new_post.title,
            new_post.content,
            new_post.views,
            new_post.account_id
        ]
        
        DatabaseConnection.exec_params(sql, params)
    end

    def delete(id)
        sql = "DELETE FROM posts WHERE id = $1"
        DatabaseConnection.exec_params(sql, [id])
    end
end