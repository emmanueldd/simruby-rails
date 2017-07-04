require 'spec_helper'

describe Api::HashTagsController do
  # KEEP CALM this tests work on a >> RESTFULL API <<
  # All render must be in json !

  # A test content for a gazooy (just to keep DRY)
  let(:valid_attributes_gazooies) { { "user_id" => "1", "text" => "#some #test #tags #in #a #gazooy"} }

  describe "GET API index HashTags " do
    it "Lets get the all hashtag list" do
      gazooy = Gazooy.create! valid_attributes_gazooies
      all_hashtag = HashTag.all
      get :index, {}
      expect(assigns(:hash_tags)).to eq(all_hashtag)
    end
  end

  describe "GET API show HashTags" do
    it "Return all gazooies.limit(50) found on a specific hash_tag" do
      gazooy = Gazooy.create! valid_attributes_gazooies
      hash_tag = HashTag.last
      get :show, {:id => hash_tag.name}
      hash_tag = hash_tag.gazooies.limit(50).load
      expect(assigns(:gazooies)).to eq(hash_tag)
    end
  end

end
