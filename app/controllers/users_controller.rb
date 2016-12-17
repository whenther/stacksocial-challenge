class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = find_user
  end

  def update
    @user = find_user

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(article_params)

    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = find_article
  end

  def delete
    @user = find_user

    @user.delete

    redirect_to 
  end

  private

  def find_article
    Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
