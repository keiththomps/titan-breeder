require_relative "./screen"
require_relative "./controller"
require_relative "./titan_breeder"

controller = Controller.new(ENV["KEYBOARD_HOSTNAME"], ENV["KEYBOARD_USERNAME"], ENV["KEYBOARD_PASSWORD"])

breeder = TitanBreeder.new(controller)
screen = Screen.new

# Customize initial state via `ruby run.rb 10 5 3` for 10 kept, 5 collected, and 3 hatched
kept_pokemon = (ARGV[0] || 0).to_i
collected = (ARGV[1] || 0).to_i
hatched = (ARGV[2] || 0).to_i
at_breeder = false

breeder.fly_to_breeder
at_breeder = true

until kept_pokemon > 25 || File.open("quit.txt").read.include?("QUIT")
  if collected >= 5 && hatched >= 5
    breeder.open_pokemon_box
    hatched.times do
      if screen.pokemon_shiny? || screen.has_6_iv?
        breeder.store_pokemon(slot: kept_pokemon)
        kept_pokemon += 1
      else
        breeder.release_pokemon
      end
    end
    breeder.add_eggs_to_party
    collected = 0
    hatched = 0
  end

  if at_breeder
    if collected < 5
      breeder.check_egg
      if screen.breeder_has_egg?
        breeder.collect_egg
        collected += 1
      else
        breeder.dismiss_breeder
      end
    end

    breeder.bike_to_bridge
    at_breeder = false
  else
    breeder.bike_to_breeder
    at_breeder = true
  end

  if hatched < 5 && screen.egg_hatching?
    (5 - hatched).times do
      breeder.hatch_egg
      hatched += 1
      breeder.trigger_next_hatch
    end

    breeder.fly_to_breeder
    at_breeder = true
  end
end
