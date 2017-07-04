require "spec_helper"

describe PagesController do
  describe "routing" do

    it "NO routes to #index" do
      expect(get("/pages")).not_to route_to("pages#index")
    end

    it 'routes to #show using slug' do
      expect(get('/super-page')).to route_to('pages#show', id: 'super-page')
    end

    it "routes to #new" do
      expect(get("/pages/new")).to route_to("pages#new")
    end

    it "routes to #show" do
      expect(get("/pages/1")).to route_to("pages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/pages/1/edit")).to route_to("pages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/pages")).to route_to("pages#create")
    end

    it "routes to #update" do
      expect(put("/pages/1")).to route_to("pages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/pages/1")).to route_to("pages#destroy", :id => "1")
    end

    it "provides a catch-all route (i.e. /about routes to page with the slug 'about')" do
      expect(get("/about")).to route_to("pages#show", id: 'about')
    end

  end
end
