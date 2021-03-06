class BooksController < ApplicationController

   #before_action :ensure_correct_user, only: [:update, :edit]
   before_action :authenticate_user!

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index

    @book = Book.new
    @user = User.find(current_user.id)
    @books = Book.all
  end

  def edit
    @book = Book.find(params[:id])
    if
      @book.user != current_user
      redirect_to books_path
    end
  end


  def show
    @book_show = Book.find(params[:id])
		@user = @book_show.user
    @book_new = Book.new
    #@books = Book.all
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private

	def book_params
		params.require(:book).permit(:title, :body)
	end

  #def ensure_correct_user
  #end

end