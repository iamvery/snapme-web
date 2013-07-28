class TeamsController < AuthenticatedController
  respond_to :html

  def index
    @teams = Team.all
  end

  def show
    @team = find_team
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)
    respond_with @team
  end

  private

  def find_team
    Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end
end
