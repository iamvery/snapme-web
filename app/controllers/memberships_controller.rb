class MembershipsController < AuthenticatedController
  def create
    team.users << current_user
    head :ok
  end

  def destroy
    membership.destroy!
    head :ok
  end

  private

  def team
    @team ||= Team.find(params[:id])
  end

  def membership
    @membership ||= Membership.find_by_user_id_and_team_id(current_user.id, team.id)
  end
end
