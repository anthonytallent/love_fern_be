require 'rails_helper'

RSpec.describe "ferns API endpoints" do
  it 'sends a list of all a users ferns' do
    user1 = create(:user)
    shelf1 = create(:shelf, user_id: user1.id)
    fern1 = create(:fern, shelf_id: shelf1.id)
    fern2 = create(:fern, shelf_id: shelf1.id)
    fern3 = create(:fern, shelf_id: shelf1.id)

    get api_v1_user_greenhouse_path(user1.id)
    expect(response).to be_successful
    ferns_hash = JSON.parse(response.body, symbolize_names: true)
    expect(ferns_hash).to have_key(:data)
    expect(ferns_hash[:data]).to be_a(Array)
    fern_data = ferns_hash[:data]

    fern_data.each do |fern|
      expect(fern).to have_key(:id)
      expect(fern[:id]).to be_a(String)

      expect(fern).to have_key(:type)
      expect(fern[:type]).to be_a(String)

      expect(fern[:attributes]).to have_key(:name)
      expect(fern[:attributes][:name]).to be_a(String)

      expect(fern[:attributes]).to have_key(:frequency)
      expect(fern[:attributes][:frequency]).to be_a(Integer)

      expect(fern[:attributes]).to have_key(:health)
      expect(fern[:attributes][:health]).to be_a(Integer)

      expect(fern[:attributes]).to have_key(:shelf_id)
      expect(fern[:attributes][:shelf_id]).to be_a(Integer)
    end
  end

  it 'can send the information of a single fern' do
    user1 = create(:user)
    shelf1 = create(:shelf, user_id: user1.id)
    fern1 = create(:fern, shelf_id: shelf1.id)
    fern2 = create(:fern, shelf_id: shelf1.id)
    fern3 = create(:fern, shelf_id: shelf1.id)

    get api_v1_user_fern_path(user1, fern1)

    expect(response).to be_successful

    fern_hash = JSON.parse(response.body, symbolize_names: true)
    expect(fern_hash).to have_key(:data)
    expect(fern_hash[:data]).to be_a(Hash)

    fern_data = fern_hash[:data]

    expect(fern_data).to have_key(:id)
    expect(fern_data[:id]).to be_a(String)
    
    expect(fern_data).to have_key(:type)
    expect(fern_data[:type]).to be_a(String)

    expect(fern_data).to have_key(:attributes)
    expect(fern_data[:attributes]).to be_a(Hash)

    expect(fern_data[:attributes]).to have_key(:name)
    expect(fern_data[:attributes][:name]).to be_a(String)

    expect(fern_data[:attributes]).to have_key(:frequency)
    expect(fern_data[:attributes][:frequency]).to be_a(Integer)

    expect(fern_data[:attributes]).to have_key(:health)
    expect(fern_data[:attributes][:health]).to be_a(Integer)

    expect(fern_data[:attributes]).to have_key(:shelf_id)
    expect(fern_data[:attributes][:shelf_id]).to be_a(Integer)
  end
end