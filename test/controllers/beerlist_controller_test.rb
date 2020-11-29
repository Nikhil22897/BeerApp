require 'test_helper'

class BeerlistControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get beerlist_index_url
    assert_response :success
  end

end
