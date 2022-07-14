require_relative './post'
require_relative './comment'

class PostRepository
  def find_with_comments(post_id)
    sql = 'SELECT posts.id AS post_id, 
                  posts.title AS post_title, 
                  posts.content AS post_content,
                  comments.id AS comment_id, 
                  comments.content AS comment_content,
                  comments.user_name AS comment_user_name,
                  comments.posts_id AS comment_posts_id
            FROM posts
            JOIN comments
            ON posts.id = comments.posts_id
            WHERE posts.id = $1;'
    params = [post_id]

    result_set = DatabaseConnection.exec_params(sql, params)
    result = result_set[0]

    post = Post.new
    post.id = result["post_id"]
    post.title = result["post_title"]
    post.content = result["post_content"]

    result_set.each do |record|
        comment = Comment.new
        comment.id = record["comment_id"]
        comment.content = record["comment_content"]
        comment.user_name = record["comment_user_name"]
        post.comments << comment
    end
    return post
  end
end