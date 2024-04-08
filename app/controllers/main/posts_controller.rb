# frozen_string_literal: true

module Main
  class PostsController < Main::ApplicationController
    before_action :set_post, only: %i[show edit update destroy post_published cancel]

    def index
      @pagy, @posts = pagy_countless(Post.published_or_pending_for_user(current_user.id).order(created_at: :desc), items: 10)

      render 'scrollable_list' if params[:page]
    end

    def show; end

    def new
      @post = current_user.posts.build
    end

    def edit
      authorize @post, :edit?
    end

    def create
      @post = current_user.posts.build(post_params)

      respond_to do |format|
        if @post.save
          format.html { redirect_to main_post_url(@post), notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @post, :update?

      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to main_post_url(@post), notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @post, :destroy?

      @post.destroy!

      respond_to do |format|
        format.html { redirect_to main_posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def post_published
      authorize @post, :update?

      @post = Post.find(params[:id])

      @post.make_published!
      flash[:success] = 'Your post has been published.'
      redirect_to main_post_path(@post)
    end

    def cancel
      authorize @post, :update?

      @post = Post.find(params[:id])

      @post.cancel!
      flash[:success] = 'Your post has been cancelled.'
      redirect_to main_post_path(@post)
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
