require "spec_helper"

describe HashTagsController do
  describe "routing" do

    it "NO routes to #index" do
      expect(get("/hash_tags")).not_to route_to("hash_tags#index")
    end

    it "NO routes to #new" do
      expect(get("/hash_tags/new")).not_to route_to("hash_tags#new")
    end

    it "routes to #show" do
      expect(get("/hash_tags/1")).to route_to("hash_tags#show", :id => "1")
    end

    it "NO routes to #edit" do
      expect(get("/hash_tags/1/edit")).not_to be_routable
    end

    it "NO routes to #create" do
      expect(post("/hash_tags")).not_to route_to("hash_tags#create")
    end

    it "NO routes to #update" do
      expect(put("/hash_tags/1")).not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete("/hash_tags/1")).not_to be_routable
    end

  end
end
