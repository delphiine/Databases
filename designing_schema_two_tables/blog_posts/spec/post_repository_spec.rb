require 'post_repository'

def reset_all_tables
    seed_sql = File.read('spec/seeds_blog_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_test' })
    connection.exec(seed_sql)
end

describe PostRepository do
    before(:each) do 
        reset_all_tables
    end

    it "returns a post and its comments" do
        repo = PostRepository.new
        post = repo.find_with_comments(3)

        expect(post.title).to eq("title3")
        expect(post.content).to eq("content3")
        expect(post.comments.first.user_name).to eq("user_name3")
    end
end