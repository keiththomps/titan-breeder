require 'open3'

class Screen
  BREEDER_HAS_EGG = "50x50+1320+758"
  EGG_HATCHING = "100x50+426+877"
  HAS_6_IV = "172x312+1472+230"
  POKEMON_SHINY = "50x50+1822+170"

  def method_missing(method_name, *args, &block)
    image_name = method_name.to_s.gsub("?", "")
    `convert #{screencapture} -crop #{Object.const_get "Screen::#{image_name.upcase}"} test.png`
    difference = Open3.popen3("magick compare -metric DSSIM test.png #{image_name}.png difference.png") { |_, _, e| e.read }

    puts "#{image_name.upcase}: #{difference} (#{difference.to_f < 0.01})"

    difference.to_f < 0.01
  end

  def screencapture
    osascript <<-END
      tell application "System Events" to tell process "Game Capture HD"
        set frontmost to true
        tell application "System Events" to keystroke "c" using {command down, shift down}
      end tell
    END

    sleep 0.5

    # get file name
    Dir.glob('/Users/geshafer/Desktop/*.png').each do |file|
      `mv #{file.gsub(" ", "\\ ")} tmp/tmp.png`
    end

    "tmp/tmp.png"
  end

  def osascript(script)
    system 'osascript', *script.split(/\n/).map { |line| ['-e', line] }.flatten
  end
end
