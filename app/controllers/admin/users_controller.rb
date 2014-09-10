class Admin::UsersController < ApplicationController
	before_action :admin_pages
	before_action :can_not_change_admin, only: [:update, :destroy]

  def index
  	@users = User.paginate(page: params[:page], per_page: 20)
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	@user.password = @user.email
  	if @user.save
  		flash[:success] = "创建成功"
	  	redirect_to admin_users_path
		else
			flash[:error] = "创建失败！"
			render 'new'
  	end
  	
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	
  	@user.update(user_params)
  	if @user.save
  		flash[:success] = "更新成功!"
  		redirect_to admin_users_path(@user)
  	else
  		flash[:error] = "更新失败！"
  		render 'edit'
  	end
  end



  def destroy

  end

  private
  	def admin_pages
  		redirect_to root_path unless current_user.is_admin?
  	end

  	def user_params
  		params[:user].permit(:username, :email, :is_admin)
  	end

  	def can_not_change_admin
  		@user = User.find(params[:id])
  		if @user.email == "admin@admin.com"
  			flash[:error] = "admin用户不可修改"
  			redirect_to admin_users_path
  		end
  	end


end
