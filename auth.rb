#RODAUTH_DATABASE_URL="postgres://localhost/rodauth_hanami_development"
RODAUTH_DATABASE_URL='sqlite://db.sqlite3' # requires sqlite3

require 'sequel'
require 'roda'

Sequel.extension :migration
DB = Sequel.connect(RODAUTH_DATABASE_URL)
Sequel::Migrator.run(DB, 'migrate/') unless Sequel::Migrator.is_current?(DB, 'migrate/')
Sequel::Migrator.run(DB, 'migrate_password/') unless Sequel::Migrator.is_current?(DB, 'migrate_password/')
DB.extension :date_arithmetic
DB.freeze
puts "DB: #{DB.opts[:adapter]}://#{DB.opts[:user]}:*@#{DB.opts[:host]}:#{DB.opts[:port]}/#{DB.opts[:database]}"


class Auth < Roda
  plugin :middleware

  plugin :rodauth, json: true do
    enable :create_account, :login, :logout, :jwt

    db DB

    account_password_hash_column :ph

    jwt_secret '1'
  end

  route do |r|
    env['rodauth'] = rodauth
    r.rodauth
  end
end
