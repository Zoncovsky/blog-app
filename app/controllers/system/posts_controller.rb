# frozen_string_literal: true

module System
  class PostsController < System::ApplicationController
    before_action :set_post, only: %i[show edit update destroy]

    def index
      @q = Post.ransack(params[:q])
      @posts = @q.result(distinct: true)
      @pagy, @posts = pagy(@q.result)
    end

    def show; end

    def new
      @post = current_user.posts.build
    end

    def edit; end

    def create
      @post = current_user.posts.build(post_params)

      respond_to do |format|
        if @post.save
          format.html { redirect_to system_post_url(@post), notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to system_post_url(@post), notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @post.destroy!

      respond_to do |format|
        format.html { redirect_to system_posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def post_published
      @post = Post.find(params[:id])

      @post.make_published!
      flash[:success] = "Post #{@post.id} has been published."
      redirect_to system_post_path(@post)
    end

    def cancel
      @post = Post.find(params[:id])

      @post.cancel!
      flash[:success] = "Post #{@post.id} has been cancelled."
      redirect_to system_post_path(@post)
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(policy(Post).permitted_attributes)
    end
  end
end
