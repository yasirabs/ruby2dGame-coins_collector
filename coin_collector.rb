
require 'ruby2d'

set title: "Coin Collector", width: 300, height: 300, borderless: false

@img = Image.new('wat.png',z: 1)

@coin = Sprite.new(
  'coin.png',
  clip_width: 84,
  time: 300,
  loop: true,z: 2
)

@hero = Sprite.new(
  'hero.png',
  width: 78,
  height: 99,
  clip_width: 78,
  time: 250,
  animations: {
    walk: 1..2,
    climb: 3..4,
    cheer: 5..6
  },z: 2
)
@total_coins = 0
@text = Text.new(
  "Coins collected = #{@total_coins}",
  x: 0, y: 0,
  size: 20,
  color: 'red',
  z: 10
)

@x_speed = 0
@y_speed = 0
@movement_speed = 1

on :key_down do |event|
  if event.key == 'left'
    @x_speed = -@movement_speed
    @y_speed = 0
    @hero.play animation: :walk, loop: true, flip: :horizontal
  elsif event.key == 'right'
    @x_speed = @movement_speed
    @y_speed = 0
    @hero.play animation: :walk, loop: true
  elsif event.key == 'up'
    @x_speed = 0
    @y_speed = -@movement_speed
    @hero.play animation: :climb, loop: true
  elsif event.key == 'down'
    @x_speed = 0
    @y_speed = @movement_speed
    @hero.play animation: :climb, loop: true, flip: :vertical
end
end

update do
  handle_movement

  @hero.x += @x_speed
  @hero.y += @y_speed

  coins_collection
end

def handle_movement
  @hero.x = 0 if @hero.x >= 300
  @hero.y = 0 if @hero.y >= 300

  @hero.x = 300 if @hero.x <= -1
  @hero.y = 300 if @hero.y <= -1
end

def coins_collection
  if @total_coins == 5
     @coin.remove
     @hero.play animation: :cheer
  elsif (@hero.x == @coin.x) || (@hero.y == @coin.y)
     @total_coins +=1
     @text.text = "Coins collected = #{@total_coins}"
     @coin.x = @coin.y = rand(1..250)
   end
end

@coin.play

show
