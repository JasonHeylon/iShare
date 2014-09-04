class CategoriesController < ApplicationController
	def show
		@category = Category.find(params[:id])
		@articles = @category.articles.paginate(page: params[:page], per_page: 30)
		@categories = Category.all
		@tags = Article.tag_counts_on(:tags)
	end


	private
		def category_params
			params.require(:category).permit(:name)
		end

end


