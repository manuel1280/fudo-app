ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.table_exists?(:products)
    create_table :products do |t|
      t.string   :name,       null: false
      t.string   :status,     null: false
      t.datetime :created_at, null: false
    end
  end

  unless ActiveRecord::Base.connection.table_exists?(:user_sessions)
    create_table :user_sessions do |t|
      t.string   :user,    null: false
      t.string   :password, null: false
      t.string   :token,    null: true, default: nil
      t.datetime :created_at, null: false
    end
  end
end
