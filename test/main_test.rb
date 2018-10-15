::RBNACL_LIBSODIUM_GEM_LIB_PATH = "libsodium.dll"
require 'minitest/autorun'
require 'open3'
require 'rbnacl'
require_relative '../src/Asd_illust_req.rb'

class MainTest < Minitest::Test
    def test_sample
        asd = Asd_illust_req.new
        $bot.send_message('aaa', '')
        assert_equal message.respond , a
    end

    def test_sample2
        assert_equal 'a' , 'a'
    end
end