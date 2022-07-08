require 'post_repository'

RSpec.describe PostRepository do
    def reset_posts_table
        seed_sql = File.read('spec/seeds_social_network.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_posts_table
    end

    it "returns all posts" do
        repo = PostRepository.new

        posts = repo.all
        expect(posts.length).to eq(3)

        expect(posts[0].id).to eq(1)
        expect(posts[0].title).to eq('title1')
        expect(posts[0].content).to eq('content1')
        expect(posts[0].views).to eq(3)
        expect(posts[0].account_id).to eq(1)

        expect(posts[1].id).to eq(2)
        expect(posts[1].title).to eq('title2')
        expect(posts[1].content).to eq('content2')
        expect(posts[1].views).to eq(7)
        expect(posts[1].account_id).to eq(1)

        expect(posts[2].id).to eq(3)
        expect(posts[2].title).to eq('title3')
        expect(posts[2].content).to eq('content3')
        expect(posts[2].views).to eq(8)
        expect(posts[2].account_id).to eq(1)
    end

    it "returns a single post" do
        repo = PostRepository.new
        post = repo.find(2)

        expect(post.id).to eq(2)
        expect(post.title).to eq('title2')
        expect(post.content).to eq('content2')
        expect(post.views).to eq(7)
        expect(post.account_id).to eq(1)
    end

    it "adds new record to the 'posts' table" do
        repo = PostRepository.new

        new_post = Post.new
        new_post.id = 4
        new_post.title = "title4"
        new_post.content = "content4"
        new_post.views = 2
        new_post.account_id = 1

        repo.create(new_post)
        all_posts = repo.all

        expect(all_posts.length).to eq(4)

        expect(all_posts).to include(
            have_attributes(
                id: new_post.id,
                title: new_post.title,
                content: new_post.content,
                views: new_post.views,
                account_id: new_post.account_id
            )
        )
    end

    it "deletes a post" do
        repo = PostRepository.new
        all_posts = repo.all
        expect(all_posts.length).to eq 3
        
        repo.delete(3)
        
        all_posts = repo.all
        expect(all_posts.length).to eq 2
    end

    it "deletes multiple posts" do
        repo = PostRepository.new
        all_posts = repo.all
        expect(all_posts.length).to eq 3
    
        repo.delete(2)
        repo.delete(3)

        all_posts = repo.all
        expect(all_posts.length).to eq(1)
    end
end
