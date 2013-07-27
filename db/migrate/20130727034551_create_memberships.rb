class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :user, null: false
      t.belongs_to :team, null: false
      t.foreign_key :users, dependent: :delete
      t.foreign_key :teams, dependent: :delete
    end
  end
end
