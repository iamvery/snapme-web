class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid,      null: false
      t.string :username, null: false
      t.string :snapshot
    end

    add_index :users, %i(provider uid),          unique: true
    add_index :users, %i(provider uid username), unique: true
  end
end
