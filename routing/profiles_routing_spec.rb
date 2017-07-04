require "spec_helper"

describe ProfilesController do
  describe "routing" do

    it "NO routes to #index" do
      expect(get("/profiles")).not_to route_to("profiles#index")
    end

    it "NO routes to #new" do
      expect(get("/profiles/new")).not_to route_to("profiles#new")
    end

    it "routes to #show" do
      expect(get("/profiles/1")).to route_to("profiles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/profiles/1/edit")).to route_to("profiles#edit", :id => "1")
    end

    it "NO routes to #create" do
      expect(post("/profiles")).not_to route_to("profiles#create")
    end

    it "routes to #update" do
      expect(put("/profiles/1")).to route_to("profiles#update", :id => "1")
    end

    it "NO routes to #destroy" do
      expect(delete("/profiles/1")).not_to be_routable
    end

    it 'routes to #follow' do
      expect(post('profiles/1/follow/2')).to route_to('profiles#follow', profile_id: '1', user_id: '2')
    end

    it 'routes to #unfollow' do
      expect(delete('profiles/1/unfollow/2')).to route_to('profiles#unfollow', profile_id: '1', user_id: '2')
    end

    it 'routes to #followers' do
      expect(get('profiles/1/followers')).to route_to('profiles#followers', profile_id: '1')
    end

    it 'routes to #followees' do
      expect(get('profiles/1/followees')).to route_to('profiles#followees', profile_id: '1')
    end

    it 'routes to #mentions' do
      expect(get('profiles/1/mentions')).to route_to('profiles#mentions', profile_id: '1')
    end

  end
end
