class BooksController < ApplicationController
  before_action :authenticate_user!
  # ログインユーザーによってのみ実行可能
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  # 現在ログインしているユーザーをモデルオブジェクトとして利用できます。
  # 関連付けがされている場合、子要素・親要素の取得などが可能です。

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    # コメントのインスタンス変数を記述
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # current_user	サインインしているユーザーを取得する
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end


end
