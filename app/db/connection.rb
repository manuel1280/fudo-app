def establish_connection
  ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: 'db/fudo_app.sqlite3'
  )
end

def seed_database
  UserSession.find_or_create_by!(user: 'johan', password: 'holamundo')
end