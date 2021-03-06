class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_person!, except: [:index, :show]
  before_action :check_role, except: [:index, :show]

  require 'will_paginate/array'

  def index
    @posts = Post.all.order(created_at: :desc)
    @page = (params[:page] || 1).to_i
    @posts = @posts.paginate(page: @page, per_page: 20)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.draft = post_params_draft
    @post.person = current_person

    if @post.save
      redirect_to @post, notice: post_created_notice
    else
      render action: 'new'
    end
  end

  def update

    @post.draft = post_params_draft

    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.
      All efforts, nomatter how small, deserve cake.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Deleting that blogpost must have been a hard decision.
    We suggest drowning your sorrows in some cake."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def check_role
    redirect_to posts_path unless current_person.has_role? :admin
  end

  def post_created_notice
    if @post.draft?
      'Post was saved as a draft. Maybe you should prepare some cake!'
    else
      'Post was successfully published. Bring out that cake!'
    end
  end

  def post_params_draft
    params[:commit] != 'Publish'
  end

  def post_params
    params.require(:post).permit(:title, :description, :picture, :full_name)
  end
end
