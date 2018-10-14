::RBNACL_LIBSODIUM_GEM_LIB_PATH = "libsodium.dll"
require 'minitest/autorun'
require 'open3'
require '../src/Main.rb'

class MainTest < Minitest::Test
    def setup
        Open3.popen3("ruby" , "ping.rb")
    end
    def test_sample
        $bot.message(:'req!help') do |event|
            assert_equal event.respond , a
        end
    end

    def test_sample2
        assert_equal 'a' , 'a'
    end
end