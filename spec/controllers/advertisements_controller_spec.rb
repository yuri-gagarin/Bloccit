require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do
  let(:my_ad) { Advertisement.create!(title: "Dr. Evil", body: "The Ransom", price: 1_000_000 )}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_ad] to @advertisements" do
      get :index
      expect(assigns(:advertisements)).to eq([my_ad])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_ad.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: my_ad.id}
      expect(response).to render_template(:show)
    end

    it "assigns my_ad to @advertisement" do
      get :show, {id: my_ad.id}
      puts :advertisement
      expect(assigns(:advertisement)).to eq(my_ad)
    end
  end

  describe "GET #new" do
    it "renders the #new view" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "instantiates @advertisement" do
      get :new
      expect(assigns(:advertisement)).not_to be_nil
    end
  end

  describe "ad create" do
    it "increases the count of Advertisement by 1" do
      expect {post :create, advertisement: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1}}.to change(Advertisement, :count).by(1)
    end

    it "assigns the new advertisement to @advertisment" do
      post :create, advertisement: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1}
      expect(assigns(:advertisement)).to eq(Advertisement.last)
    end

    it "redirects to the new advertisement" do
      post :create, advertisement: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1}
      expect(response).to redirect_to Advertisement.last
    end
  end
end
