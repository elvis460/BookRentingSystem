class BookController < ApplicationController
  before_action :find_book , only: [:edit,:update,:destroy,:upload_image,:show]
  before_filter :require_login , except: [:index]
  before_filter :require_admin , except: [:index,:show]

  def index
    @book = Book.all.group_by(&:category)
  end

  def list
    @book = Book.all
  end

  def new
    @comicbook_bn=Comicbook.count.to_i
    @novel_bn=Novel.count.to_i
    @magazine_bn =Magazine.count.to_i
  end

  def create
    @book = Book.new(book_params)
    @book.borrowed = false
    if @book.save
      @category = Category.new
      @category.type = params[:book][:category]
      @category.BN = params[:book][:BN]
      @category.name = params[:book][:name]
      @category.save
      redirect_to '/book/list'
    else
      render 'new'
    end
  end

  def edit
    @comicbook_bn=Comicbook.count.to_i
    @novel_bn=Novel.count.to_i
    @magazine_bn =Magazine.count.to_i
  end

  def update
    @category = Category.find_by(BN: @book.BN)
    if @book.update(book_params)
      @category.type = params[:book][:category]
      @category.BN = params[:book][:BN]
      @category.name = params[:book][:name]
      @category.save
      redirect_to '/book/list'
    else
      render 'new'
    end
  end

  def upload_image
    @book.image =params[:image]
    if params[:remove_image]
    @book.remove_image!
    end
    @book.save
    redirect_to "/book/edit/#{@book.id}"
  end

  def destroy
    @book.destroy
    redirect_to '/book/list'
  end

  def show

  end
  private

  def book_params
    params.require(:book).permit(:name,:BN,:category)
  end

  def find_book
    @book=Book.find(params[:id])
  end
end
