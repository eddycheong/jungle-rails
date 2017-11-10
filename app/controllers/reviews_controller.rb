class ReviewsController < ApplicationController
  before_action :require_login

  def create
    @product = Product.find(params[:product_id])
    
    @review = @product.reviews.new(review_params)
    @review.user = User.find(session[:user_id])

    if @review.save
      redirect_to @product, notice: 'Review Created'
    else
      redirect_to @product
    end
  end

  def destroy
    @review = Review.find params[:id]

    @product = Product.find(@review.product_id)

    @review.destroy
    redirect_to @product
  end

  private
    def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to login_path
      end
    end

    def logged_in?
      !session[:user_id].nil?
    end

    def review_params
      params.require(:review).permit(
        :rating,
        :description,
        :product_id
      )
    end
end
