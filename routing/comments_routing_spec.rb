require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "NO routes to #index" do
      expect(get("/comments")).not_to route_to("comments#index")
    end

    it "NO routes to #new" do
      expect(get("/comments/new")).not_to be_routable
    end

    it "NO routes to #show" do
      expect(get("/comments/1")).not_to be_routable
    end

    it "NO routes to #edit" do
      expect(get("/comments/1/edit")).not_to be_routable
    end

    it "routes to #create" do
      expect(post("/comments")).to route_to("comments#create")
    end

    it "NO routes to #update" do
      expect(put("/comments/1")).not_to be_routable
    end

    it "NO routes to #destroy" do
      expect(delete("/comments/1")).not_to be_routable
    end

  end
end
