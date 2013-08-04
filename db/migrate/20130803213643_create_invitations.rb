class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string  :token, null: false
      t.index   :token, unique: true
    end
  end
end
