class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @word   = params[:word]
    @range  = params[:range]
    @search = params[:search]

    if @range == "user" 
      @users = User.where(search_condition("name"))
      
    else
      @posts = Post.where(search_condition("title"))
    end
  end

  private

  def search_condition(column)
    case @search
    when "perfect_match"
      ["#{column} = ?", @word]
    when "forward_match"
      ["#{column} LIKE ?", "#{@word}%"]
    when "backward_match"
      ["#{column} LIKE ?", "%#{@word}"]
    else
      ["#{column} LIKE ?", "%#{@word}%"]
    end
  end
end
