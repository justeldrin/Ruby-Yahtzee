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

    class Score
        def initialize()
            @val = 0
            @selected = false
        end

        def setVal(i)
            @val = i
        end
        
        def select
            @selected = true
        end

        def getSelected
            return @selected
        end

        def getVal
            return @val
        end
    end

    turn = 1
    rerolls = 2
    di = Array.new(5)
    # initiallize di with separate coordinates
    di[0] = Dice.new(50, 50)
    di[1] = Dice.new(100, 50)
    di[2] = Dice.new(150, 50)
    di[3] = Dice.new(200,50)
    di[4] = Dice.new(250, 50)

    sc = Array.new(18)
    for i in 0..17 do
        sc[i] = Score.new()
    # key down
    on :key_down do |event|
        case event.key
            # roll button = R key
            when 'r'
                if (rerolls > 0)
                    for i in 0..4 do
                        di[i].roll
                    end
                    rerolls -= 1
                end
                for i in 0..16 do
                    chooseCalc(i, di, scoreArr)
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
            when 'a'
                chooseCalc(0, di, sc)
                if(!sc[0].getSelected)
                    nextTurn()
                end
                
        end
    end
    
    def chooseCalc(choice, die, scoreArr)
        if(!sc[choice].getSelected)
            case choice
                when '0'#aces
                    sc[0].setVal(upperSums(1, die))
                when '1'#twos
                    sc[1].setVal(upperSums(2, die))
                when '2'#threes
                    sc[2].setVal(upperSums(3, die))
                when '3'#fours
                    sc[3].setVal(upperSums(4, die))
                when '4'#fives
                    sc[4].setVal(upperSums(5, die))
                when '5'#sixes
                    sc[5].setVal(upperSums(6, die))
                when '6'#Num total
                    sc[6].setVal(numTotal(sc))
                when '7'#Bonus
                    if(sc[6].getVal >= 65)
                        sc[7].setVal(35)
                    else
                        sc[7].setVal(0)
                    end
                when '8'#uppertotal
                    sc[8].setVal(sc[6].getVal + sc[7].getVal)
                when '9'#three of a kind
                    sc[9].setVal(threeKind(die))
                when '10'#four of a kind
                    sc[10].setVal(fourKind(die))
                when '11'#Yachzee - five of a kind
                    sc[11].setVal(yahtzee(die))
                when '12'# Full house
                    sc[12].setVal(fullHouse(die))
                when '13'#straight of 4
                    sc.[13].setVal(smallStraight(die))
                when '14'#straight of 5
                    sc.[14].setVal(largeStraight(die))
                when '15'#chance
                    sc.[15].setVal(chance(die))
                when '16'#low total
                    sc.[16].setVal(lowTotal(sc))
                when '17'#Grand total
                    sc.[17].setVal(sc[16].getVal + sc[8].getVal)
            end
        end
    end

    def nextTurn()
        if(turn != 13)
            turn += 1
            rerolls = 2
        else
            sc[17] = grandTotal(di)
        end
    end

    def numTotal(scoreArr)
        sum = 0
        for i in 0..5
            sum += scoreArr[i].getVal
        end
    end

    def lowTotal(scoreArr)
    sum = 0
        for i in 9..15
            sum += scoreArr[i].getVal
        end
    end
    
    #Table UI
    tableImage = Image.new('scoreTable.png',
        x:480, y:0
        )
    
        acesText = Text.new('',
            x: 635, y: 26,
            color: 'black'
        )
    
        twosText = Text.new('',
            x: 635, y: 48,
            color: 'black'
        )
    
        
        threesText = Text.new('',
            x: 635, y: 70,
            color: 'black'
        )
        
        foursText = Text.new('',
            x: 635, y: 92,
            color: 'black'
        )
    
        
        fivesText = Text.new('',
            x: 635, y: 114,
            color: 'black'
        )
    
        
        sixesText = Text.new('',
            x: 635, y: 136,
            color: 'black'
        )
    
        upperTotalScoreText = Text.new('',
            x: 635, y: 158,
            color: 'black'
        )
        
        bonusText = Text.new('',
            x: 635, y: 180,
            color: 'black'
        )
    
        upperTotalText = Text.new('',
            x: 635, y: 204,
            color: 'black'
        )
    
        
        threeKindText = Text.new('',
            x: 635, y: 272,
            color: 'black'
        )
    
        fourKindText = Text.new('',
            x: 635, y: 294,
            color: 'black'
        )
    
        fiveKindText = Text.new('',
            x: 635, y: 316,
            color: 'black'
        )
    
        fullHouseText = Text.new('',
            x: 635, y: 338,
            color: 'black'
        )
    
        fourStraightText = Text.new('',
            x: 635, y: 360,
            color: 'black'
        )
    
        fiveStraightText = Text.new('',
            x: 635, y: 382,
            color: 'black'
        )
    
        chanceText = Text.new('',
            x: 635, y: 404,
            color: 'black'
        )
    
        grandLowerText = Text.new('',
            x: 635, y: 430,
            color: 'black'
        )
    
        grandUpperText = Text.new('',
            x: 635, y: 452,
            color: 'black'
        )
    
        grandTotalText = Text.new('',
            x: 635, y: 474,
            color: 'black'
        )
show