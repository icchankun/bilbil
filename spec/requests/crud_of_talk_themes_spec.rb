require 'rails_helper'

RSpec.describe "トークテーマのCRUD機能のテスト", type: :request do
  let(:admin){ create(:admin)}
  let!(:category){ create(:category) }

  describe "GET /api/v1/talk_themes" do
    let!(:talk_themes){ create_list(:talk_theme, 3) }

    it '全カテゴリーを取得する' do
      get api_v1_talk_themes_path
      res = JSON.parse(response.body)
      expect(res.count).to eq 3
      expect(res[0].keys).to eq ["id", "content", "category_id", "likes"]
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/talk_themes" do
    let(:params) {{ talk_theme: attributes_for(:talk_theme) }}
    subject { post api_v1_talk_themes_path, params: params }

    it 'レコードが新規登録される' do
      sign_in admin
      expect{ subject }.to change{ TalkTheme.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /api/v1/talk_themes/:id" do
    let(:old_talk_theme){ create(:talk_theme) }
    let(:params) {{ talk_theme: attributes_for(:talk_theme) }}

    it '指定したレコードが更新される' do
      sign_in admin
      patch api_v1_talk_theme_path(old_talk_theme.id), params: params
      res = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(res['content']).to eq(params[:talk_theme][:content])
    end
  end

  describe "DELETE /api/v1/talk_themes/:id" do
    let!(:talk_theme){ create(:talk_theme) }
    subject { delete api_v1_talk_theme_path(talk_theme.id) }

    it '指定したレコードが削除される' do
      sign_in admin
      expect { subject }.to change { TalkTheme.count }.by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
