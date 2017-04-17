require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe '#create' do
    let!(:commented_post) { FactoryGirl.create :post }
    context 'with non-empty comment' do
      let(:comment_params) { FactoryGirl.attributes_for(:comment, post_id: commented_post.id) }
      let(:request) { post :create, params: { comment: comment_params } }
      it 'creates new comment' do
        expect{ request }.to change(Comment, :count).by(1)
      end

      it 'redirects to post' do
        expect(request).to redirect_to commented_post
      end
    end

    context 'with empty comment' do
      let(:comment_params) { FactoryGirl.attributes_for(:invalid_comment, post_id: commented_post.id) }
      let(:request) { post :create, params: { comment: comment_params } }

      it "doesn't creates new comment" do
        expect{ request }.to change(Comment, :count).by(0)
      end

      it 'redirects to same template' do
        expect(request).to redirect_to commented_post
      end
    end
  end

end
