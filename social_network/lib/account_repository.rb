require_relative './account'

class AccountRepository
    def all
        sql = 'SELECT id, email, username FROM accounts'
        result_set = DatabaseConnection.exec_params(sql, [])
        accounts = []

        result_set.each do |item|
            account = Account.new
            account.id = item['id'].to_i
            account.email = item['email']
            account.username = item['username']

            accounts << account
        end

        return accounts
    end

    def find(id)
        sql = 'SELECT id, email, username FROM accounts WHERE id = $1'
        result_set = DatabaseConnection.exec_params(sql, [id])

        item = result_set[0]
        account = Account.new
        account.id = item['id'].to_i
        account.email = item['email']
        account.username = item['username']

        return account

    end

    def create(new_account)
        sql = 'INSERT INTO 
        accounts (id, email, username) 
        VALUES ($1, $2, $3)'

        params = [
            new_account.id,
            new_account.email,
            new_account.username,
        ]
        
        DatabaseConnection.exec_params(sql, params)
    end

    def delete(id)
        sql = 'DELETE FROM accounts WHERE id = $1'
        DatabaseConnection.exec_params(sql, [id])
    end
end
