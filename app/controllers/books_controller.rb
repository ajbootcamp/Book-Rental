class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_admin!, only: [:new, :create]

  def index
    @books = Book.page(params[:page]).per(10)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      flash.now[:alert] = 'Failed to update the book.'
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_url, notice: 'Book was successfully deleted.'
    else
      Rails.logger.error("Failed to delete the book: #{@book.errors.full_messages}")
      flash[:alert] = 'Failed to delete the book.'
      redirect_back(fallback_location: books_url)
    end
  end

  def create
    @book = Book.new(book_params)
    @book.available_quantity = @book.total_quantity

    if @book.save
      redirect_to @book, notice: 'Book was successfully added.'
    else
      flash.now[:alert] = 'Failed to add the book.'
      render :new
    end
  end

  def rent
    @book = Book.find(params[:id])
    if @book.available_quantity > 0
      Rental.create(user: current_user, book: @book, due_date: 7.days.from_now)
      @book.decrement!(:available_quantity)
      redirect_to @book, notice: 'Book rented successfully.'
    else
      redirect_to @book, alert: 'Sorry, the book is not available for rental.'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :total_quantity, :price)
  end

  def authorize_admin!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user&.admin?
  end
end
