require 'net/ssh'

class Controller
  def initialize(hostname, username, password)
    @_ssh = Net::SSH.start(hostname, username, password: password)

    ObjectSpace.define_finalizer(self, lambda { |object_id|
      ssh.close
    })

    # initialize the connection before issuing commands
    # and release the keys to clear out the buffer
    release_keys
  end

  def press(button, seconds = nil)
    puts "PRESS: #{button}"
    key_down Array(button).map { |b| BUTTON_MAP[b] }
    sleep seconds if !seconds.nil?
    release_keys
  end

  def hold(button)
    puts "HOLDS: #{button}"
    key_down Array(button).map { |b| BUTTON_MAP[b] }
  end

  private

  def ssh
    @_ssh
  end

  def key_down(keys)
    codes = 6.times.map { |n| KEY_CODE[keys[n]] }
    result = ssh.exec! "echo -ne '\\0\\0#{ codes.join }' > /dev/hidg0"
    raise result if result != ""
  end

  def release_keys
    result = ssh.exec! "echo -ne '\\0\\0\\0\\0\\0\\0\\0\\0' > /dev/hidg0"
    raise result if result != ""
  end

  BUTTON_MAP = {
    :up => "w",
    :down => "s",
    :left => "a",
    :right => "d",
    :d_up => "t",
    :d_down => "v",
    :d_left => "3",
    :d_right => "4",
    :a => "c",
    :b => "x",
    :x => "e",
    :y => "r",
    :l => "f",
    :r => "q",
    :+ => "f3",
  }

  KEY_CODE = {
    nil => "\\0",

    "a" => "\\x04",
    "b" => "\\x05",
    "c" => "\\x06",
    "d" => "\\x07",
    "e" => "\\x08",
    "f" => "\\x09",
    "g" => "\\x0a", # not working for some reason
    "h" => "\\x0b",
    "i" => "\\x0c",
    "j" => "\\x0d",
    "k" => "\\x0e",
    "l" => "\\x0f",
    "m" => "\\x10",
    "n" => "\\x11",
    "o" => "\\x12",
    "p" => "\\x13",
    "q" => "\\x14",
    "r" => "\\x15",
    "s" => "\\x16",
    "t" => "\\x17",
    "u" => "\\x18",
    "v" => "\\x19",
    "w" => "\\x1a",
    "x" => "\\x1b",
    "y" => "\\x1c",
    "z" => "\\x1d",

    "3" => "\\x20",
    "4" => "\\x21",

    "f3" => "\\x3c",
  }
end
