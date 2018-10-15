::RBNACL_LIBSODIUM_GEM_LIB_PATH = "libsodium.dll"
require 'minitest/autorun'
require 'open3'
require 'rbnacl'
require '../src/Main.rb'

class MainTest < Minitest::Test
    def test_sample
        $bot.send_message('aaa', '')
        assert_equal message.respond , a
    end

    def test_sample2
        assert_equal 'a' , 'a'
    end
end