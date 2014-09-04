class TagsController < ApplicationController

	def show
		@tag_name = params[:tag_name]
		@articles = Article.tagged_with(@tag_name).paginate(page: params[:page], per_page: 30)

		@categories = Category.all
		@tags = Article.tag_counts_on(:tags)
	end

end
