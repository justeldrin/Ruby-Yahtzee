require 'ruby2d'

set title: 'Yahtzee', background: '#006400', width: 700, height: 500

    class Dice 

        def initialize(x, y)
            @score = 0
            @held = false
            @diceSprite = Sprite.new('di.png', clip_width: 50, time: 100, x: x, y: y, 
                animations:{
                    one: 0..0,
                    two: 1..1,
                    three: 2..2,
                    four: 3..3,
                    five: 4..4,
                    six: 5..5,
                    redOne: 6..6,
                    redTwo: 7..7,
                    redThree: 8..8,
                    redFour: 9..9,
                    redFive: 10..10,
                    redSix: 11..11,
                    cycle: 0..5
                })
                @diceSprite.play animation: :cycle, loop: true
        end


        public

        def roll 
            if(!@held)
                @score = rand(6) + 1    # random number between 0-5, add 1, 1-6
                case @score
                    when 1
                        @diceSprite.play animation: :one, loop: true
                    when 2
                        @diceSprite.play animation: :two, loop: true
                    when 3
                        @diceSprite.play animation: :three, loop: true
                    when 4
                        @diceSprite.play animation: :four, loop: true
                    when 5
                        @diceSprite.play animation: :five, loop: true
                    when 6
                        @diceSprite.play animation: :six, loop: true
                end
            end
            
        end

        def hold
            # makes user keep certain dice the same number and highlights the selected dice red
            @held = !@held
            if(@held)
                case @score
                    when 1
                        @diceSprite.play animation: :redOne, loop: true
                    when 2
                        @diceSprite.play animation: :redTwo, loop: true
                    when 3
                        @diceSprite.play animation: :redThree, loop: true
                    when 4
                        @diceSprite.play animation: :redFour, loop: true
                    when 5
                        @diceSprite.play animation: :redFive, loop: true
                    when 6
                        @diceSprite.play animation: :redSix, loop: true
                end
            # unhighlights dice that the user wants to roll again
            else
                case @score
                    when 1
                        @diceSprite.play animation: :one, loop: true
                    when 2
                        @diceSprite.play animation: :two, loop: true
                    when 3
                        @diceSprite.play animation: :three, loop: true
                    when 4
                        @diceSprite.play animation: :four, loop: true
                    when 5
                        @diceSprite.play animation: :five, loop: true
                    when 6
                        @diceSprite.play animation: :six, loop: true
                end
            end
        end

        def getScore
            
            return @score
        end

    end

    
    di = Array.new(6)
    
    # initiallize di with separate coordinates
    di[0] = Dice.new(50, 50)
    di[1] = Dice.new(100, 50)
    di[2] = Dice.new(150, 50)
    di[3] = Dice.new(200,50)
    di[4] = Dice.new(250, 50)
    di[5] = Dice.new(300,50)

    
    # key down
    on :key_down do |event|
        case event.key
            # roll button = R key
            when 'r'
                for i in 0..5 do
                    di[i].roll
                end
            # hold dice = corresponding number key
            when '1'
                di[0].hold
            when '2'
                di[1].hold
            when '3'
                di[2].hold
            when '4'
                di[3].hold
            when '5'
                di[4].hold
            when '6'
                di[5].hold
        end
    end
show