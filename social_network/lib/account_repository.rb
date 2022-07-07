require_relative './account'

class AccountRepository
    def all
        sql = 'SELECT id, email, username, post FROM accounts'
        result_set = DatabaseConnection.exec_params(sql, [])
        accounts = []

        result_set.each do |item|
            account = Account.new
            account.id = item['id'].to_i
            account.email = item['email']
            account.username = item['username']
            account.post = item['post']

            accounts << account
        end

        return accounts
    end

    def find(id)
        sql = 'SELECT id, email, username, post FROM accounts WHERE id = $1'
        result_set = DatabaseConnection.exec_params(sql, [id])

        item = result_set[0]
        account = Account.new
        account.id = item['id'].to_i
        account.email = item['email']
        account.username = item['username']
        account.post = item['post']

        return account

    end

    def create(new_account)
        sql = 'INSERT INTO 
        accounts (id, email, username, post) 
        VALUES ($1, $2, $3, $4)'

        params = [
            new_account.id,
            new_account.email,
            new_account.username,
            new_account.post
        ]
        
        DatabaseConnection.exec_params(sql, params)
    end

    def delete(id)
        sql = 'DELETE FROM accounts WHERE id = $1'
        DatabaseConnection.exec_params(sql, [id])
    end

end
