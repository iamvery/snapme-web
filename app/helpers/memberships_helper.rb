module MembershipsHelper
  def membership_switch(team)
    data = {
      team_id: team.id,
      create_endpoint: memberships_path,
      destroy_endpoint: membership_path(team),
      toggle: :switch,
    }

    check_box_tag(
      :membership, '1',
      team.users.include?(current_user),
      rel:  'team-membership',
      data: data)
  end
end
