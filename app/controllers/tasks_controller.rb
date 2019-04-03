class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy, :update]
  before_action :set_task, only: [:show, :edit, :update, :destroy, :assign]
  before_action :edit_task, only: [:edit]

  def index
    @tasks = Task.visible
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, notice: 'タスクの作成に成功しました。'
    else
      render @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'タスクの更新に成功しました。'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: 'タスクの削除に成功しました。'
  end

  def assign
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def edit_task
    redirect_to root_path if @task.user != current_user
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :user_id, :status)
  end
end
