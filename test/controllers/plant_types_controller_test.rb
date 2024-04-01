require "test_helper"

class PlantTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get plant_types_show_url
    assert_response :success
  end
end
