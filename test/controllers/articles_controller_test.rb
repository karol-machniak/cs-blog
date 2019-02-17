require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do

    @article = create :article
    @user = create :user
  end

  teardown do


  end
  
  test 'GET #index show articles' do
    get articles_path
    assert_response :success
    assert_includes(assigns[:articles], @article)
    assert_template 'index'

  end

  test 'POST #create when not signed in' do
  
    post articles_path, params: {
      article: { title: 'test title', text: 'textextext', terms_of_service: '1' }
    }
    assert_redirected_to new_user_session_path
    

  end


  # test "the truth" do
  #   assert true


  # end




end
