class CommentsController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:create, :destroy]

  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
    render json: @comments
  end

  def show
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    render json: @comment
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(
          commenter: params[:commenter],
          body: params[:body],
          status: params[:status]
          )
    render json: @comment
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
  end
end
