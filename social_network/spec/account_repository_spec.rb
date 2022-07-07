require 'account_repository'

RSpec.describe AccountRepository do
    def reset_accounts_table
        seed_sql = File.read('spec/seeds_social_network.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_accounts_table
    end
      
    it "returns all accounts" do

        repo = AccountRepository.new
        accounts = repo.all
        
        expect(accounts.length).to eq(3)
        
        expect(accounts[0].id).to eq(1) 
        expect(accounts[0].email).to eq('test1@email.com')  
        expect(accounts[0].username).to eq('username1') 
        expect(accounts[0].post).to eq('post1')
        
        expect(accounts[1].id).to eq(2)
        expect(accounts[1].email).to eq('test2@email.com')
        expect( accounts[1].username).to eq('username2')
        expect(accounts[1].post).to eq('post2')
        
        expect(accounts[2].id).to eq(3)
        expect(accounts[2].email).to eq('test3@email.com')
        expect(accounts[2].username).to eq('username3')
        expect(accounts[2].post).to eq('post3')

    end

    it "returns a single account" do 
        repo = AccountRepository.new
        accounts = repo.find(1)

        expect(accounts.id).to eq(1) 
        expect(accounts.email).to eq('test1@email.com')  
        expect(accounts.username).to eq('username1') 
        expect(accounts.post).to eq('post1')
    end

    it "adds new record to the 'accounts' table" do
        repo = AccountRepository.new

        new_account = Account.new
        new_account.id = 4
        new_account.email = 'test4@email.com' 
        new_account.username = 'username4'
        new_account.post = 'post4'

        repo.create(new_account)
        all_accounts = repo.all

        expect(all_accounts.length).to eq(4)

        expect(all_accounts).to include(
            have_attributes(
                id: new_account.id,
                email: new_account.email,
                username: new_account.username,
                post: new_account.post
            )
        )
    end

    it "deletes an account" do
        repo = AccountRepository.new
        repo.delete(4)

        all_accounts = repo.all
        expect(all_accounts.length).to eq 3
    end 
end