class SearchController < ApplicationController
  def search_by_BN
    @book_by_BN =  Book.find_by(BN: params[:BN])
    if @book_by_BN.present?
      redirect_to "/book/show/#{@book_by_BN.id}"
    else
      render '/search/index'
    end
  end

  def search_by_name
    @book_by_name = Book.where("name LIKE ?", "%#{params[:book_name]}%")
    if @book_by_name.blank?
      render '/search/index'
    end
  end

  def rented
    @book = Book.where(borrowed: true)
  end

  def date_order
    @book = BookRent.where(borrowed: true).order(dead_line: :ASC)
  end

  def hot
    @book = Book.all
  end
end
