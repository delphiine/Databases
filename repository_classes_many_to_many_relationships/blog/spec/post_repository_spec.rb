require 'post_repository'

RSpec.describe PostRepository do
    def reset_posts_table
        seed_sql = File.read('spec/seeds_blogs_tags_2.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'blogs_tags_2_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_posts_table
    end

    it "returns all posts for the given tag" do
        repo = PostRepository.new
        posts = repo.find_by_tag('coding')

        expect(posts.length).to eq 4
        expect(posts[0].title).to eq("How to use Git")
        expect(posts[2].title).to eq("Using IRB")
        expect(posts[3].id).to eq(7)
    end
end