require 'spec_helper'

describe Api::GazooiesController do
  # KEEP CALM this tests work on a >> RESTFULL API <<
  # All render must be in json !

  # A test content for a gazooy (just to keep DRY)
  let(:valid_attributes) { { "user_id" => "1", "text" => "Some really long text just to say that my gazooy is long enough"} }

  describe "Test API index [stream] on gazooies" do
    it "Lets get the gazooies list ... API style !" do
      gazooies = Gazooy.create! valid_attributes
      get :index, {}
      expect(assigns(:gazooies)).to eq([gazooies])
    end
  end

  describe "Test API show on a gazooy" do
    it "check the render for a [ok] gazooy" do
      gazooy = Gazooy.create! valid_attributes
      get :show, {:id => gazooy.to_param}
      expect(assigns(:gazooy)).to eq(gazooy)
    end
    it "check the render for a [ko] gazooy" do
      get :show, {:id => 999999} # 9999999 just to show it's not supposed to exist :-)
      expect(assigns(:gazooy)).to be_nil
    end
  end
end
