require 'test_helper'

class ActivityTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activity_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create activity_type" do
    assert_difference('ActivityType.count') do
      post :create, :activity_type => { }
    end

    assert_redirected_to activity_type_path(assigns(:activity_type))
  end

  test "should show activity_type" do
    get :show, :id => activity_types(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => activity_types(:one).id
    assert_response :success
  end

  test "should update activity_type" do
    put :update, :id => activity_types(:one).id, :activity_type => { }
    assert_redirected_to activity_type_path(assigns(:activity_type))
  end

  test "should destroy activity_type" do
    assert_difference('ActivityType.count', -1) do
      delete :destroy, :id => activity_types(:one).id
    end

    assert_redirected_to activity_types_path
  end
end
