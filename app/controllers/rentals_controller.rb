class RentalsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [:admin_index]

  def index
    @rentals = current_user.rentals
  end

  def show
    @rental = current_user.rentals.find(params[:id])
  end

  def return
    @rental = current_user.rentals.find(params[:id])
    
    if @rental.returned?
      redirect_to rentals_path, alert: 'This book has already been returned.'
    else
      @rental.update(returned: true)
      @rental.book.increment!(:available_quantity)
      redirect_to rentals_path, notice: 'Book returned successfully.'
    end
  end

  def admin_index
    @rentals = Rental.all
    render 'admin_index'
  end

  private

  def authorize_admin!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user&.admin?
  end
end
