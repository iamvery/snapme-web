class AddUniquenessConstraintToMemberships < ActiveRecord::Migration
  def up
    # Remove duplicate memberships. http://wiki.postgresql.org/wiki/Deleting_duplicates
    execute <<-SQL
      DELETE FROM memberships
      WHERE id IN (
        SELECT id
        FROM (
          SELECT id, row_number() over (partition BY team_id, user_id ORDER BY id) AS rnum
          FROM memberships
        ) t
        WHERE t.rnum > 1
      )
    SQL

    add_index :memberships, %i(team_id user_id), unique: true
  end

  def down
    remove_index :memberships, %i(team_id user_id)
  end
end
