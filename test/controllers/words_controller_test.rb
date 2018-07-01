require 'test_helper'

class WordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get words_index_url
    assert_response :success
  end

  test "should get count" do
    get words_count_url
    assert_response :success
  end

  test "should get stat" do
    get words_stat_url
    assert_response :success
  end

end
