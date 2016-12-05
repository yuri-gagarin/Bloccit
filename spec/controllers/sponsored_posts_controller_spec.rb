require 'rails_helper'
include RandomData

RSpec.describe SponsoredPostsController, type: :controller do

  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}

  let(:ad_post) { my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_int)}

  describe "GET show" do

    it "returns http success" do
      get :show, topic_id: my_topic.id, id: ad_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, topic_id: my_topic.id, id: ad_post.id
      expect(response).to render_template(:show)
    end

    it "assigns my_post to @sponsored_post" do
     get :show, topic_id: my_topic.id, id: ad_post.id
      expect(assigns(:sponsored_post)).to eq(ad_post)
    end
  end
  describe "GET #new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end

    it "instantiates @sponsored_post" do
      get :new, topic_id: my_topic.id
      expect(assigns(:sponsored_post)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of SponsoredPost by 1" do
      expect {post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_int}}.to change(SponsoredPost, :count).by(1)
    end

    it "assigns the new post to @sponsored_post" do
      post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_int}
      expect(assigns(:sponsored_post)).to eq SponsoredPost.last
    end

    it "redirects to the new post" do
      post :create, topic_id: my_topic.id,  sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_int}
      expect(response).to redirect_to [my_topic, SponsoredPost.last]
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: ad_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, topic_id: my_topic.id, id: ad_post.id
      expect(response).to render_template :edit
    end

    it "assigns sponsored_post to be updated to @sponsored_post" do
      get :edit, topic_id: my_topic.id, id: ad_post.id

      post_instance = assigns(:sponsored_post)

      expect(post_instance.id).to eq ad_post.id
      expect(post_instance.title).to eq ad_post.title
      expect(post_instance.body).to eq ad_post.body
    end
  end

  describe "PUT update" do
    it "updates sponsored_post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = RandomData.random_int

      put :update, topic_id: my_topic.id, id: ad_post.id, sponsored_post: {title: new_title, body: new_body, price: new_price}

      updated_post = assigns(:sponsored_post)
      expect(updated_post.id).to eq ad_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
      expect(updated_post.price).to eq new_price
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = RandomData.random_int

      put :update, topic_id: my_topic.id, id: ad_post.id, sponsored_post: {title: new_title, body: new_body, price: new_price}
      expect(response).to redirect_to ([my_topic, ad_post])
    end
  end

  describe "DELETE destroy" do
    it "deletes the sponsored_post" do
      delete :destroy, topic_id: my_topic.id, id: ad_post.id
      count = SponsoredPost.where({id: ad_post.id}).size
      expect(count).to eq 0
    end

    it "redirects to topic show" do
      delete :destroy, topic_id: my_topic.id, id: ad_post.id
      expect(response).to redirect_to my_topic
    end
  end

end