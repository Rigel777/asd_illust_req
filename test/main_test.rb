::RBNACL_LIBSODIUM_GEM_LIB_PATH = "libsodium.dll"
require 'minitest/autorun'
require 'open3'
require 'rbnacl'
require '../src/Asd_illust_req.rb'
require 'discordrb'

class MainTest < Minitest::Test
    def test_sample
        @tmp = 'a'
        asd = Asd_illust_req.new
        asd.bot.run(true)
        asd.bot.command(:help){|event|
            a = event.respond "req!help"
            @tmp = a.content
        }
        assert_equal nil , @tmp
    end

    def test_sample2
        assert_equal 'a' , 'a'
    end
end