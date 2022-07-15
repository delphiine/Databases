require_relative './post'
require_relative './tag'

class TagRepository
  def find_by_post(post)
    sql = 'SELECT tags.id, tags.name
            FROM tags
            JOIN posts_tags ON posts_tags.tag_id = tags.id
            JOIN posts ON posts_tags.post_id = posts.id
            WHERE posts.title = $1;'
    params = [post]
    result_set = DatabaseConnection.exec_params(sql, params)
    tags_list = []

    result_set.each do |record|
        tag = Tag.new
        tag.id = record["id"].to_i
        tag.name = record["name"]
        tags_list << tag
    end
    return tags_list
  end
end