module TeamsHelper
  def view_teams_link
    link_to 'View Teams', teams_path, class: %i(btn btn-primary)
  end

  def add_team_link
    link_to 'Add Team', new_team_path, rel: 'add-team', class: %i(btn btn-primary)
  end

  def edit_team_link(team)
    link_to 'Edit', edit_team_path(team), class: :btn
  end

  def delete_team_link(team)
    link_to(
      'Delete',
      team_path(@team),
      method: :delete,
      rel:    'delete-team',
      data:   { confirm: 'Are you sure?' },
      class:  %i(btn btn-danger),
    )
  end
end
