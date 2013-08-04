class CreateInvitationRequests < ActiveRecord::Migration
  def change
    create_table :invitation_requests do |t|
      t.string :email, null: false
      t.index  :email, unique: true
    end
  end
end
