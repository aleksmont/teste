require "test_helper"

class IpHelperTest < ActionView::TestCase
  test "test ip success" do
    generated_ip = Array.new(4) { rand(1..254) }.join('.')

    assert_equal IpHelper::get_info(generated_ip)[:success], true
  end

  test "test ip false" do
    assert_equal IpHelper::get_info('123456')[:success], false
  end
end