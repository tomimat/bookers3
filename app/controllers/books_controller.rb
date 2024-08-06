class BooksController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @book = Book.new
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

   def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
   end

  def edit
    @book = Book.find(params[:id])
  end

   def update
     @book = Book.find(params[:id])

    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :edit
    end

   end

   private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end
end
