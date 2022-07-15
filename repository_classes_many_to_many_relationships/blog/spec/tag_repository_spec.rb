require 'tag_repository'

RSpec.describe TagRepository do
    def reset_tags_table
        seed_sql = File.read('spec/seeds_blogs_tags_2.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'blogs_tags_2_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_tags_table
    end

    it "returns all tags for the given post" do
        repo = TagRepository.new
        tags = repo.find_by_post("Using IRB")

        expect(tags.length).to eq 2
        expect(tags[0].name).to eq("coding")
        expect(tags[1].name).to eq("ruby")
        expect(tags[1].id).to eq(4)
    end
end