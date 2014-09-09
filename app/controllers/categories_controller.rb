class CategoriesController < ApplicationController

	before_action :only_admin, except: :show

	def show
		@category = Category.find(params[:id])
		@articles = @category.articles.paginate(page: params[:page], per_page: 30)
		@categories = Category.all
		@tags = Article.tag_counts_on(:tags)
	end

	def index
		@categories = Category.all	
	end
	def edit
		@category = Category.find(params[:id])
	end
	def update
		@category = Category.find(params[:id])
		@category.update(category_params)
		@category.save
		flash[:success] = "更新成功"
		redirect_to edit_category_path(@category)\
	end

	def new
		@category = Category.new
	end
	def create
		@category = Category.create(category_params)
		flash[:success] = "创建成功"
		redirect_to edit_category_path(@category)
	end

	def destroy
		Category.find(params[:id]).destroy
		flash[:success] = "删除成功"
		redirect_to categories_path
	end


	private
		def category_params
			params.require(:category).permit(:name)
		end
		def only_admin
			redirect_to root_path unless current_user.is_admin?
		end

end


