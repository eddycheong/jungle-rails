class ReviewsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    
    new_review_params = review_params
    new_review_params[:user_id] = session[:user_id]

    @review = @product.reviews.new(new_review_params)
    @review.user = current_user

    if @review.save
      redirect_to @product, notice: 'Review Created'
    else
      redirect_to @product
    end
  end

  private
    def review_params
      params.require(:review).permit(
        :rating,
        :description,
        :product_id
      )
    end
end
