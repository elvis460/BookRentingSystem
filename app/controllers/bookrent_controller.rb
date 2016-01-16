class BookrentController < ApplicationController
  before_action :find_bookrent , only: [:edit,:update,:destroy]
  before_filter :require_login
  before_filter :require_admin
  def new
    @book = Book.find(params[:id])
  end

  def list
    @bookrent = BookRent.all
  end

  def create
    @bookrent = BookRent.new
    @bookrent.book_id = params[:book_id]
    @user = User.find_by(name: params[:user_name])
    if @user.blank?
      redirect_to '/book/index'
    return
    end
    @bookrent.user_id = @user.id
    @bookrent.save
    @bookrent.dead_line = (Time.now + 7.days).strftime("%Y/%m/%d %k:%M")
    @bookrent.extra_fee = 10
    @bookrent.borrowed=true
    @bookrent.save
    @book = Book.find(params[:book_id])
    @book.borrowed=true
    @book.hot_count = @book.book_rents.length
    @book.save
    redirect_to '/book/index'
  end

  def edit
  end

  def update
    @bookrent.borrowed=false
    @bookrent.save
    @book = @bookrent.book
    @book.borrowed=false
    @book.save
    redirect_to '/book/index'
  end

  def destroy
    @bookrent.destroy
    redirect_to '/bookrent/list'
  end
  private

  def find_bookrent
    @bookrent = BookRent.find(params[:id])
  end
end
