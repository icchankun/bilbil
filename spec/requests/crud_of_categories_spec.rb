require 'rails_helper'

RSpec.describe "カテゴリーのCRUD機能のテスト", type: :request do
  let(:admin){ create(:admin)}

  describe "GET /api/v1/categories" do
    let!(:categories){ create_list(:category, 3) }

    it '全カテゴリーを取得する' do
      get api_v1_categories_path
      res = JSON.parse(response.body)
      expect(res.count).to eq 3
      expect(res[0].keys).to eq ["id", "name", "talk_themes"]
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/categories" do
    let(:params) {{ category: attributes_for(:category) }}
    subject { post api_v1_categories_path, params: params }

    it 'レコードが新規登録される' do
      sign_in admin
      expect{ subject }.to change{ Category.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /api/v1/categories/:id" do
    let(:old_category){ create(:category) }
    let(:params) {{ category: attributes_for(:category) }}

    it '指定したレコードが更新される' do
      sign_in admin
      patch api_v1_category_path(old_category.id), params: params
      res = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(res['name']).to eq(params[:category][:name])
    end
  end

  describe "DELETE /api/v1/categories/:id" do
    let!(:category){ create(:category) }
    subject { delete api_v1_category_path(category.id) }

    it '指定したレコードが削除される' do
      sign_in admin
      expect { subject }.to change { Category.count }.by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
