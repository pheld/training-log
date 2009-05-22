require 'test_helper'

class FitnessSamplesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fitness_samples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fitness_sample" do
    assert_difference('FitnessSample.count') do
      post :create, :fitness_sample => { }
    end

    assert_redirected_to fitness_sample_path(assigns(:fitness_sample))
  end

  test "should show fitness_sample" do
    get :show, :id => fitness_samples(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => fitness_samples(:one).id
    assert_response :success
  end

  test "should update fitness_sample" do
    put :update, :id => fitness_samples(:one).id, :fitness_sample => { }
    assert_redirected_to fitness_sample_path(assigns(:fitness_sample))
  end

  test "should destroy fitness_sample" do
    assert_difference('FitnessSample.count', -1) do
      delete :destroy, :id => fitness_samples(:one).id
    end

    assert_redirected_to fitness_samples_path
  end
end
