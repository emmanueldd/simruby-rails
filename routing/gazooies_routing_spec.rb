require "spec_helper"

describe GazooiesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/gazooies")).to route_to("gazooies#index")
    end

    it "NO routes to #new" do
      expect(get("/gazooies/new")).not_to route_to("gazooies#new")
    end

    it "routes to #show" do
      expect(get("/gazooies/1")).to route_to("gazooies#show", :id => "1")
    end

    it "NO routes to #edit" do
      expect(get("/gazooies/1/edit")).not_to be_routable
    end

    it "routes to #create" do
      expect(post("/gazooies")).to route_to("gazooies#create")
    end

    it "NO routes to #update" do
      expect(put("/gazooies/1")).not_to be_routable
    end

    it "NO routes to #destroy" do
      expect(delete("/gazooies/1")).not_to be_routable
    end

  end
end
