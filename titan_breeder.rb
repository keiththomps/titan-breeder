class TitanBreeder
  attr_reader :controller

  def initialize(controller)
    @controller = controller
  end

  def fly_to_breeder
    # open menu
    controller.press :x, 0.1
    sleep 1

    # open map
    controller.press :right, 1
    controller.press :up, 0.5
    controller.press :a
    sleep 2

    # navigate route 5 to breeder
    controller.press [:d_up, :d_right], 0.1
    sleep 1

    # confirm flight
    controller.press :a
    sleep 1
    controller.press :a
    sleep 3

    controller.press :left, 0.5
    sleep 0.1
    controller.press [:up, :right], 1
    sleep 2
  end

  def check_egg
    controller.press :a, 0.1
    sleep 1.5 # We found an egg, do you want it?
  end

  def collect_egg
    controller.press :a, 0.1
    sleep 4 # You received an egg from the breeder
    controller.press :a, 0.1
    sleep 1.5 # Your egg was sent to a box
    controller.press :a, 0.1
    sleep 1.5 # Take good care of it
    controller.press :a, 0.1
    sleep 0.5
  end

  def dismiss_breeder
    controller.press :b
    sleep 0.5
    controller.press :b
    sleep 1
    controller.press :b
    sleep 0.5
  end

  def bike_to_bridge
    controller.hold [:right, :down]
    sleep 0.5
    controller.hold :right
    sleep 0.5
    controller.press [:right, :r], 3.5
    sleep 0.5
  end

  def bike_to_breeder
    controller.press :d_left, 0.8
    controller.press :left, 6.2
    controller.press [:left, :up], 0.75
    controller.press :up, 0.25
    sleep 0.1
    controller.press [:up, :right], 1
    sleep 0.5
  end

  def hatch_egg
    controller.press :a
    sleep 17
    controller.press :a
    sleep 3
  end

  def trigger_next_hatch
    controller.press :left, 1
    sleep 0.5
  end

  def open_pokemon_box
    # open menu
    controller.press :x, 0.1
    sleep 1

    # open pokemon
    controller.press :left, 1
    controller.press :up, 0.5
    controller.press :a, 0.1
    sleep 2

    # open box
    controller.press :r, 0.1
    sleep 2
    controller.press :left
    sleep 0.25
    controller.press :down
    sleep 0.25
  end

  def store_pokemon(slot:)
    controller.press :a # menu
    sleep 0.75
    controller.press :a # move
    sleep 0.75
    controller.press :right
    sleep 0.75
    controller.press :up
    sleep 0.75
    controller.press :l # to storage
    sleep 0.75

    # position pokemon
    (slot / 5).times { controller.press :right; sleep 0.5; }
    (slot % 5).times { controller.press :down; sleep 0.5; }
    controller.press :a # put down

    # return cursor
    controller.press :r, 0.1
    sleep 0.5
    (slot / 5).times { controller.press :left; sleep 0.5; }
    (slot % 5).times { controller.press :up; sleep 0.5; }
    sleep 0.5
    controller.press :left
    sleep 0.25
    controller.press :down
    sleep 0.25
  end

  def release_pokemon
    controller.press :a # menu
    sleep 0.75
    controller.press :up
    sleep 0.75
    controller.press :up
    sleep 0.75
    controller.press :a # release
    sleep 1.5
    controller.press :up
    sleep 0.75
    controller.press :a # yes
    sleep 1.5
    controller.press :a # released
    sleep 0.75
  end

  def add_eggs_to_party
    controller.press :right
    sleep 0.5
    controller.press :up
    sleep 0.5
    controller.press :y
    sleep 0.5
    controller.press :y
    sleep 0.5
    controller.press :a
    sleep 0.5
    controller.press :up
    sleep 0.5
    controller.press :a
    sleep 0.5
    controller.press :left
    sleep 0.5
    controller.press :down
    sleep 0.5
    controller.press :a
    sleep 0.5
    controller.press :b
    sleep 2
    controller.press :b
    sleep 1
    controller.press :b
    sleep 0.5
  end
end
