# 01. Songクラスの作成
class Song
end
song1 = Song.new
song2 = Song.new
song3 = Song.new

# 02. Songクラスにメソッドを定義
class Song
  def info
    "Song ID: #{object_id}"
  end
end
song1.info
song2.info
song3.info

# 03. Songオブジェクトを配列に格納
box = []
box.push(song1)
box.push(song2)
box.push(song3)
box
box.each{|song| p song.info }

# 04. Songクラスに@titleを設定するメソッドを定義
class Song
  def set_title(name)
    @title = name
  end
end
song1.set_title("My Way")
song2.set_title("My Way")
song3.set_title("My Way")
box

# 05. @titleに代入・参照するためのアクセサを定義
box.each{|song| puts song.title } # error

class Song
  def title
    @title
  end
  
  def title=(name)
    @title = name
  end
end

box.each{|song| puts song.title } # ok
song1.title = "My Way 1"
song2.title = "My Way 2"
song3.title = "My Way 3"
box

# 06. アクセサを省略記法で定義(1)
class Song
  attr_reader :title
  attr_writer :title
end
song1.title = "My Way 1-1"
song2.title = "My Way 2-2"
song3.title = "My Way 3-3"
box

# 07. アクセサを省略記法で定義(2)
class Song
  attr_accessor :title
end
song1.title = "My Way 1-1-1"
song2.title = "My Way 2-2-2"
song3.title = "My Way 3-3-3"
box

# 08. Songクラスのインスタンスメソッド一覧を取得
Song.instance_methods - Object.instance_methods

# 09. Songクラスに@artist用のアクセサを追加
class Song
  attr_accessor :title, :artist
end
song1.artist = "Flank Sinatra"
song2.artist = "Flank Sinatra"
song3.artist = "Flank Sinatra"

# 10. Songクラスの初期化用メソッドを定義
class Song
  def initialize(title, artist)
    @title  = title
    @artist = artist
  end

  def inspect
    "<Song: #{@title} -- #{@artist}>"
  end
end
new_song1 = Song.new("My Way", "Flank Sinatra")
new_song1

# 11. Songクラスの初期化時にキーワード指定できるよう変更
class Song
  def iniaizlie(title:, artist:)
    @title  = title
    @artist = artist
  end
end
new_song2 = Song.new(title: "My Way", artist: "Flank Sinatra")
new_song2

new_song3 = Song.new()	# error

# 12. キーワード省略時のデフォルト値を指定
class Song
  def initialize(title: "No title", artist: "No artist")
    @title  = title
    @artist = artist
  end
end
new_song3 = Song.new()	# ok
new_song3


# 13. Songクラス完成
class Song
  attr_accessor :title, :artist
  
  def initialize(title: "No title", artist: "No artist")
    @title  = title
    @artist = artist
  end
  
  def inspect
    "<Song: #{@title} -- #{@artist}>"
  end
end

# 14. Songクラスを継承したDemoSongクラスを作成
class DemoSong < Song
  attr_accessor :duration, :lyrics
  
  DEFAULT_VALUES = {
    title: "No title",
    artist: "No artist",
    lyrics: "...",
    duration: 0 }

  def initialize(values={})
    values = DEFAULT_VALUES.merge(values)
    super(title: values[:title], artist: values[:artist])
    
    @lyrics   = values[:lyrics]
    @duration = values[:duration]
  end

  def inspect
    super + " #{@lyrics} (#{@duration})"
  end
end
demo = DemoSong.new(title: "My Way", artist: "Frank Sinatra",
                    duration: 255, lyrics: "And now, the end is near...")

# 15. @@playsクラス変数に再生回数を保持して、DemoSong.playsで再生回数を表示
class DemoSong < Song
  @@plays = 0

  def play
    @@plays += 1
    "Play> #{self.inspect}"
  end

  def self.total_plays
    "Total #{@@plays} plays"
  end
end
