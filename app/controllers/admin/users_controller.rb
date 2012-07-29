class Admin::UsersController < Admin::ApplicationController
  before_filter :get_users, only: [:index]
  before_filter :get_user, except: [:index, :new, :create]

  def index
    respond_to do |format|
      format.html
      format.json { render json: @users, status: :ok }
      format.xml { render xml: @users, status: :ok }
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    # Only allow editing of roles.
    if params[:user].present? and params[:user][:roles].present?
      params[:user][:roles].each do |role|
        @user.add_role(role.to_sym)
      end
    end

    respond_to do |format|
      format.html { redirect_to edit_admin_user_path(@user), notice: 'Updated user.' }
      format.json { render json: @user, status: :ok }
      format.xml { render xml: @user, status: :ok }
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'User deleted.' }
      format.json { render json: @user, status: :deleted }
      format.xml { render xml: @user, status: :deleted }
    end
  end

  private

  def get_users
    @users = User.all || []
  end

  def get_user
    @user = User.find(params[:id]) || nil
  end
end