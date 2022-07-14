class ArticlesController < ApplicationController

  require 'base64'
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
      status: params[:status],
      views: 0,
      floater: 0.1,
      deci: 0.1,
      publish: DateTime.now,
      publishD: Date.today,
      publishT: Time.now,
      bool: true,
      image: 0
    )
    render json: @article
  end

  def update #re-finds the article and updates it.
    @article = Article.find(params[:id])
    @article.update(
      title: params[:title],
      body: params[:body],
      status: params[:status],
      views: params[:views],
      floater: params[:floater],
      deci: params[:deci],
      publish: DateTime.now,
      publishD: Date.today,
      publishT: Time.now,
      bool: params[:bool],
      image: Base64.encode64(params[:image])
    )
    render json: @article
  end

  def destroy 
    @articles = Article.all
    @article = Article.find(params[:id])
    @article.destroy
  end

  def addViews
    @article = Article.find(params[:id])
    @article.update(
      views: params[:views].to_i + 100
    )
    render json: @article.views
  end
  
  def readViews
    @article = Article.find(params[:id])
    strViews = "This article has " +  params[:views] + " views"
    render json: strViews
  end

end
