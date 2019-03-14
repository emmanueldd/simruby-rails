require 'spec_helper'

describe Api::UserGazooiesController do
  # KEEP CALM this tests work on a >> RESTFULL API <<
  # All render must be in json !
  # help for that route : /api/users/:user_id/gazooies
  # note that : /api/users/index / show / edit etc. must not exist !

  # A test content for a gazooy (just to keep DRY)
  let(:valid_attributes_gazooies) { { "user_id" => "1", "text" => "#some #test #tags #in #a #gazooy"} }


  # A test content for a new User (just to keep DRY)
  let(:valid_attributes_user) { { "email" => "test@example.com",
                                  "password" => "qweasd",
                                  "password_confirmation" => "qweasd" } }


  describe 'GET Users Gazooies list' do
    it 'Test on api_user_gazooies#index' do
      user = User.create! valid_attributes_user
      gazooy = Gazooy.create! valid_attributes_gazooies
      get :index, {user_id: user.id}
      expect(assigns(:gazooies)).to eq([gazooy])
    end

    it 'Test on api_user_gazooies#index no gazooies' do
      user = User.create! valid_attributes_user
      get :index, {user_id: user.id}
      expect(assigns(:gazooies)).to be_empty
    end

    it 'Test on api_user_gazooies#index no users and no gazooies' do
      get :index, {user_id: 999999} # 9999999 just to show it's not supposed to exist :-)
      expect(assigns(:gazooies)).to be_nil
    end


  end
end
