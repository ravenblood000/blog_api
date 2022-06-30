class ArticlesController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:create, :update, :destroy]

  def index
    @articles = Article.all
    render json: @articles, include:
      :comments
  end

  def show
    @article = Article.find(params[:id])
    render json: @article, include:
      :comments
  end

  def create
    @article = Article.create(
      title: params[:title],
      body: params[:body],
      status: params[:status]
    )
    render json: @article
  end

  def update #re-finds the article and updates it.
    @article = Article.find(params[:id])
    @article.update(
      title: params[:title],
      body: params[:body],
      status: params[:status]
    )
    render json: @article
  end

  def destroy 
    @articles = Article.all
    @article = Article.find(params[:id])
    @article.destroy
  end

end
