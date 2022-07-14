require_relative 'lib/database_connection'
require_relative 'lib/post_repository'


DatabaseConnection.connect('blog_test')

repo = PostRepository.new
post = repo.find_with_comments(2)

puts "These are the comments for #{post.title}"
post.comments.each do |comment|
    puts comment.content
end