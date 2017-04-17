require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe '#index' do
    let!(:posts) { FactoryGirl.create_list :post, 15 }
    let(:request) { get :index, params: { page: 1 } }

    it 'returns http success' do
      request
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      expect(request).to render_template('index')
    end

    it 'assigns first 10 posts to @posts ordered by created_at' do
      request
      expect(assigns(:posts)).to eq Post.order(created_at: :desc).page(1).per(10)
    end
  end

  describe '#new' do
    let(:request) { get :new }

    it 'assigns empty Post to @post' do
      request
      expect(assigns(:post)).to be_a_new Post
    end

    it 'renders new template' do
      expect(request).to render_template('new')
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      let(:post_params) { FactoryGirl.attributes_for(:post) }
      let(:request) { post :create, params: { post: post_params } }

      it 'creates new post' do
        expect{ request }.to change(Post, :count).by(1)
      end

      it 'redirects to new post' do
        expect(request).to redirect_to Post.last
      end
    end
    context 'with invalid parameters' do
      let(:post_params) { FactoryGirl.attributes_for(:invalid_post) }
      let(:request) { post :create, params: { post: post_params } }

      it "doesn't creates new post" do
        expect{ request }.to change(Post, :count).by(0)
      end

      it 'redirects to same template' do
        expect(request).to render_template('new')
      end
    end
  end

  describe '#show' do
    let!(:post) { FactoryGirl.create :post }
    let(:request) { get :show, params: { id: post.to_param } }

    it 'returns http success' do
      request
      expect(response).to have_http_status(:success)
    end

    it 'renders show template' do
      expect(request).to render_template('show')
    end

    it 'assigns post to @post' do
      request
      expect(assigns(:post)).to eq post
    end

    it 'assigns empty comment to @comment' do
      request
      expect(assigns(:comment)).to be_a_new Comment
    end

    it 'assigns all comments to @comments ordered by created_at' do
      request
      expect(assigns(:comments)).to eq post.comments.order(created_at: :asc)
    end
  end

  describe '#destroy' do
    let!(:post) { FactoryGirl.create :post }
    let!(:comment) { FactoryGirl.create(:comment, post_id: post.id) }
    let(:request) { delete :destroy, params: { id: post.to_param } }

    it 'destroys the requested post' do
      expect{ request }.to change(Post, :count).by(-1)
    end

    it 'redirects to #index' do
      expect(request).to redirect_to(:posts)
    end

    it 'destroys all comments belonging to post' do
      expect{ request }.to change{Comment.where(post_id: post.id).count}.to(0)
    end

  end

  describe '#fork' do
    let!(:forked_post) { FactoryGirl.create :post }
    let(:request) { get :fork, params: { id: forked_post.to_param } }

    it 'returns http success' do
      request
      expect(response).to have_http_status(:success)
    end

    it 'renders new template' do
      expect(request).to render_template('new')
    end

    it 'assigns empty Post to @post' do
      request
      expect(assigns(:post)).to be_a_new Post
    end

    it 'assigns Post to @post' do
      request
      expect(assigns(:post)).to be_a_new Post
    end

    it 'contain duplicate of old Post' do
      request
      expect(assigns(:post)).to have_attributes(name: forked_post.name.to_param,
                                                title: forked_post.title.to_param,
                                                snippet: forked_post.snippet.to_param)
    end
  end
end
