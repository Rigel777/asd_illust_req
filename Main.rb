require 'yaml'
require 'discordrb'

botinfo = YAML.load_file("Token.yml")

$bot = Discordrb::Commands::CommandBot.new token: botinfo["Token"], client_id: botinfo["Client_ID"], prefix: botinfo["Prefix"]

list = {}

def send_embed channel, title, color, icon, str, t
  channel.send_embed do |embed|
    embed.title = t
    if icon != ""
      embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: icon)
    end
    embed.color = color
    embed.add_field(name: title,value: str)
  end
end

$bot.ready(){
  $bot.game = "#{botinfo["Prefix"]}help | Test Bot"
}

$bot.command(:help){|event|
  send_embed($bot.channel(event.channel.id),"使い方",0x00ffff,"",["ほげほげ"].join("\n"),"Help Command")
}

$bot.command(:send){|event,name,*url|
  break unless event.user.id == 150618806308438016 || event.user.id == 350796206449885186

  if url == []
    event.respond "req!send <送る人の名前> <イラストのURL>"
    break
  end

  list.each{|usid,value|
    if $bot.user(usid).name == name
      $bot.user(usid).pm "お待たせしました！絵が完成しました！#{url.join(" ")}"
        list.delete(event.user.id)
        event.respond"送信しました📩"
      return
    end
  }
  event.respond "ユーザーが見つかりませんでした"
}


$bot.command(:list){|event|
  break unless event.user.id == 150618806308438016 || event.user.id == 350796206449885186
  result = []

  list.each{|key,value|
    result << "#{$bot.user(key).name}さんからのリクエスト\n内容:#{value}"
  }
  if list.size == 0
    send_embed($bot.channel(event.channel.id),"一覧",0x00ffff,"","リクエストはありません","イラストリクエスト")
    break
  end

  if list.size < 10
    send_embed($bot.channel(event.channel.id),"一覧",0x00ffff,"",result.join("\n"),"イラストリクエスト")
  else
    cnt = 10;
    loop{
      cnt+=10
      break if cnt > result.size
      sleep 1
      send_embed($bot.channel(event.channel.id),"一覧",0x00ffff,"",result[(cnt-10)..cnt],"イラストリクエスト")
    }
  end
}

$bot.command(:delete){|event|
  list[event.user.id] = ""
  list.delete(event.user.id)
  event.respond "リクエストが取り消されました"
}

$bot.command(:request){|event,*content|
  break if content == []

  if content.join(" ").length >= 100
    event.respond "リクエストは100文字以内でお願いします！"
    break
  end

  list[event.user.id] = content.join(" ")
  send_embed($bot.channel(event.channel.id),"内容",0x00ffff,"",content.join("\n") + "\nリクエストを取り消すにはreq!deleteと入力してください","リクエストが送信されました")
}
$bot.run

=begin
あ、今作りたいのは、あさださんにイラストリクエストを送ったら
それがキューに入って
俺が見たいときに閲覧できるって感じ
=end
