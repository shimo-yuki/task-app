class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :destroy]

  def index
    @teams = current_user.teams
    @myteams = current_user.myteams
    if params[:q] == nil
      @q = Team.ransack(params[:q])
    else
      @q = Team.search(search_params)
      @team = @q.result(distinct: true)
    end

  end

  def new
    @team = Team.new
  end

  def create
    @team = current_user.myteams.build(team_params)
    @team.save
    redirect_to team_path(@team)
  end

  def show
    @tasks = @team.tasks
    if params[:search].present?
      @users = User.search(params[:search])
    else
      @users = 0;
    end
  end

  def destroy
    @tema.destroy
    redirect_to teams_path
  end

  private

  def team_params
    params.require(:team).permit(:name, :teema, :user_id)
  end

  def set_team
      @team = Team.find(params[:id])
  end

  def search_params
    params.require(:q).permit(:name)
  end
end
