require_relative 'lib/database_connection'
require_relative 'lib/tag_repository'
require_relative 'lib/post_repository'

DatabaseConnection.connect("blogs_tags_2_test")

post_repo = PostRepository.new
posts_list = post_repo.find_by_tag("travel")

puts "These are the posts:"
posts_list.each do |post|
    puts "#{post.id} - #{post.title}"
end

tag_repo = TagRepository.new
tags_list = tag_repo.find_by_post("A foodie week in Spain")

puts "These are the tags:"
tags_list.each do |tag|
    puts "#{tag.id} - #{tag.name}"
end