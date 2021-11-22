require 'ruby2d'

set title: 'Yahtzee', background: '#006400', width: 700, height: 500

$turnCounter = 1
$rollCounter = 0

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

        def getScore  
            return @score
        end

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

        def startTurn
            @diceSprite.play animation: :cycle, loop: true
            @held = false
            @score = 0
        end
    end

    class ScoreCategory
        @calculatedScore
        @selected

        def initialize
            @calculatedScore = -1
            @selected = false
        end

        def setScore(inputScore)
            @calculatedScore = inputScore
        end

        def getScore
            return @calculatedScore
        end

        def setTrue
            @selected = true
        end

        def getSelect
            return @selected
        end
    end
        
    #Table UI
    tableImage = Image.new('scoreTable.png',
        x:480, y:0
        )
    
    textArray = Array.new(19)

    #Generates Text Objects in textArray to display scores

    initialX = 635
    initialY = 26
    for i in 0..19
        if (i == 9)
            initialY = 274
        end

        textArray[i] = Text.new('', x:initialX, y: initialY, color: 'black')
        initialY+=22
    end

    infoBox = Rectangle.new(
            x:40, y:375,
            width:400, height: 100,
            color: 'white'
    )

    $infoText = Text.new("Welcome to YAHTZEE!",
        x:44, y:380,
        style: 'bold',
        color: 'black',
        size: 15
    )

    $controlText = Text.new('Press R to re/roll',
        x:44, y:400,
        style: 'bold',
        color: 'black',
        size: 15
    )

    $controlTextTwo = Text.new('Press the corresponding key on the score table to ',
        x:44, y:420,
        style: 'bold',
        color: 'black',
        size: 15
    )

    $controlTextThree = Text.new('commit and end your turn',
        x:44, y:440,
        style: 'bold',
        color: 'black',
        size: 15
    )

    $turnText = Text.new('Turn: 1',
        x:0, y:0,
        color: 'white',
        style: 'bold'
    )

    $rollText = Text.new('Rolls: 3',
        x:380, y:0,
        color: 'white',
        style: 'bold'
    )


    
    # Calculation Methods
    def valueArray(diceArray)
        array = Array.new(5)
        for i in 0..4
            array[i] = diceArray[i].getScore
        end  
        return array
    end

    def upperSums(targetNum, diceArray)
        scoreArray = valueArray(diceArray)
        score = 0
        scoreArray.each { |dice|
        
            if (dice == targetNum)
                score += targetNum
            end
        }
        return score
    end

    def threeKind(diceArray)
        scoreArray = valueArray(diceArray)
        score = 0
        counter = scoreArray.tally
        threeCheck = false
        counter.each {|key, value|
                if(value == 3 || value == 4 || value == 5)
                    threeCheck = true
                end
        }
        if(threeCheck)  
            scoreArray.each {|dice|
                score += dice
            }
        end
        return score
    end

    def fourKind(diceArray)
        scoreArray = valueArray(diceArray)
        score = 0
        counter = scoreArray.tally
        fourCheck = false
        counter.each {|key, value|
                if(value == 4 || value == 5)
                    fourCheck = true
                end
        }
        
        if(fourCheck)
            scoreArray.each {|dice|
                score += dice
            }
        end
        return score
    end

    def fullHouse(diceArray)
        scoreArray = valueArray(diceArray)
        score = 0
        counter = scoreArray.tally
        
        houseCheckThree = false
        houseCheckTwo = false
        counter.each {|key, value|
                if(value == 2)
                    houseCheckTwo = true
                elsif(value == 3)
                    houseCheckThree = true
                end
        }

        if(!(houseCheckThree && houseCheckTwo))
            score = 0
        
        else
            score = 25
        end

        return score
    end

    def smallStraight(diceArray)
        scoreArray = valueArray(diceArray)
        score = 0
        tempArray = scoreArray.sort 
        currentNum = -1
        straightCounter = 0
        
        for i in 0..2
            if (tempArray[i] == tempArray[i + 1] - 1)
                straightCounter+=1
            end
        end

        if(straightCounter == 3)
            score = 30
        end

        tempArray = tempArray.reverse
        straightCounter = 0

        if(score != 30)
                for x in 0..2
                    if (tempArray[x] == tempArray[x + 1] + 1)
                        straightCounter+=1
                    end
                end
        end
        if(straightCounter == 3)
            score = 30
        end
        return score
    end

    def largeStraight(diceArray)
        scoreArray = valueArray(diceArray)
        score = 0
        tempArray = scoreArray.sort
        straightCounter = 0
        for i in 0..3
            if(tempArray[i] == tempArray[i + 1] - 1)
                straightCounter +=1
            end
        end

        if(straightCounter == 4)
            score = 40
        end
        return score
    end

    def yahtzee(diceArray)
        scoreArray = valueArray(diceArray)
        score = 0
        counter = scoreArray.tally
        counter.each {|key, value|
                if(value == 5)
                    score = 50
                end
        }
        return score
    end

    def chance(diceArray)
        scoreArray = valueArray(diceArray)
        score = 0
        scoreArray.each() {|dice|
            score+= dice
        }
        return score;
    end

    def updateScores(diceArr, scoreArr, textArr)
        for i in 0..5
            if(!scoreArr[i].getSelect)#Only change if that score has not been taken
                scoreArr[i].setScore(upperSums(i+1, diceArr))
                textArr[i].text = scoreArr[i].getScore
            end
        end
 
        if(!scoreArr[9].getSelect)
            scoreArr[9].setScore(threeKind(diceArr))
            textArr[9].text = scoreArr[9].getScore
        end

        if(!scoreArr[10].getSelect)
            scoreArr[10].setScore(fourKind(diceArr))
            textArr[10].text = scoreArr[10].getScore
        end

        if(!scoreArr[11].getSelect)
            scoreArr[11].setScore(yahtzee(diceArr))
            textArr[11].text = scoreArr[11].getScore
        end

        if(!scoreArr[12].getSelect)
            scoreArr[12].setScore(fullHouse(diceArr))
            textArr[12].text = scoreArr[12].getScore
        end

        if(!scoreArr[13].getSelect)
            scoreArr[13].setScore(smallStraight(diceArr))
            textArr[13].text = scoreArr[13].getScore
        end

        if(!scoreArr[14].getSelect)
            scoreArr[14].setScore(largeStraight(diceArr))
            textArr[14].text = scoreArr[14].getScore
        end

        if(!scoreArr[15].getSelect)
            scoreArr[15].setScore(chance(diceArr))
            textArr[15].text = scoreArr[15].getScore
        end
    end

    def updateSums(diceArr, scoreArr, textArr)
        
        numSum = 0
    
        for i in 0..5
            if(scoreArr[i].getSelect)
                numSum += scoreArr[i].getScore
            end
        end
        scoreArr[6].setScore(numSum)#Numtotal
        textArr[6].text = numSum
        textArr[6].color = 'blue'

        if(numSum >= 65)#bonus

            scoreArr[7].setScore(35)
            textArr[7].text = 35
        else 
            scoreArr[7].setScore(0)
            textArr[7].text = 0
            textArr[7].color = 'blue'
        end
        upSum = scoreArr[6].getScore + scoreArr[7].getScore
        scoreArr[8] =  upSum #upper total
        textArr[8].text = upSum
        textArr[8].color = 'blue'
        textArr[17].text = textArr[8].text
        textArr[17].color = 'blue'

        lowSum = 0   
        for i in 9..15
            if(scoreArr[i].getSelect)
                lowSum += scoreArr[i].getScore
            end
        end
        scoreArr[16].setScore(lowSum)
        textArr[16].text = scoreArr[16].getScore
        textArr[16].color = 'red'

        sumTotal = lowSum + upSum

        scoreArr[18].setScore(sumTotal)
        textArr[18].text = scoreArr[18].getScore
        textArr[18].color = 'purple'
        
        
        if($turnCounter == 13)
            $controlText.text = ''
            $controlTextTwo.text = ''
            $controlTextThree.text = ''
            $infoText.text = "Game Over! Thanks for playing! End Score: #{scoreArr[18].getScore}"
        end

        
        $turnCounter +=1
        $rollCounter = 0
        $rollText.text = "Rolls: 3"
        $turnText.text = "Turn: #{$turnCounter}"

        diceArr.each{|dice|
            dice.startTurn
        }
    end
*

    di = Array.new(5)
    
    # initiallize di with separate coordinates
    di[0] = Dice.new(50, 50)
    di[1] = Dice.new(100, 50)
    di[2] = Dice.new(150, 50)
    di[3] = Dice.new(200,50)
    di[4] = Dice.new(250, 50)

    categoryArray = Array.new(19)
    for i in 0..18 do
        categoryArray[i] = ScoreCategory.new()
    end
    
    # key down
 
        on :key_down do |event|
            case event.key
                # roll button = R key
                when 'r'
                    if($rollCounter != 3)
                        for i in 0..4 do
                            di[i].roll
                        end
                        updateScores(di, categoryArray, textArray)
                        $rollCounter += 1
                        $rollText.text = "Rolls: #{3 - $rollCounter}"
                    end
                # hold dice = corresponding number key
                when '1'
                    if($rollCounter != 0)
                        di[0].hold
                    end
                when '2'
                    if($rollCounter != 0)
                        di[1].hold
                    end
                when '3'
                    if($rollCounter != 0)
                        di[2].hold
                    end
                when '4'
                    if($rollCounter != 0)
                        di[3].hold
                    end
                when '5'
                    if($rollCounter != 0)
                        di[4].hold
                    end
                when 'a'
                    if(!categoryArray[0].getSelect && $rollCounter != 0)
                        categoryArray[0].setTrue
                        textArray[0].color = 'blue'
                        updateSums(di, categoryArray, textArray)
                    end
                when 's'
                    if(!categoryArray[1].getSelect && $rollCounter != 0)
                        categoryArray[1].setTrue
                        textArray[1].color = 'blue'
                        updateSums(di, categoryArray, textArray)
                    end
                when 'd'
                    if(!categoryArray[2].getSelect && $rollCounter != 0)
                        categoryArray[2].setTrue
                        textArray[2].color = 'blue'
                        updateSums(di, categoryArray, textArray)
                    end
                when 'f'
                    if(!categoryArray[3].getSelect && $rollCounter != 0)
                        categoryArray[3].setTrue
                        textArray[3].color = 'blue'
                        updateSums(di, categoryArray, textArray)
                    end
                when 'g'
                    if(!categoryArray[4].getSelect && $rollCounter != 0)
                        categoryArray[4].setTrue
                        textArray[4].color = 'blue'
                        updateSums(di, categoryArray, textArray)
                    end
                when 'h'
                    if(!categoryArray[5].getSelect && $rollCounter != 0)
                        categoryArray[5].setTrue
                        textArray[5].color = 'blue'
                        updateSums(di, categoryArray, textArray)
                    end
                when 'z'
                    if(!categoryArray[9].getSelect && $rollCounter != 0)
                        categoryArray[9].setTrue
                        textArray[9].color = 'red'
                        updateSums(di, categoryArray, textArray)
                    end
                when 'x'
                    if(!categoryArray[10].getSelect && $rollCounter != 0)
                        categoryArray[10].setTrue
                        textArray[10].color = 'red'
                        updateSums(di, categoryArray, textArray)
                    end
                when 'c'
                    if(!categoryArray[11].getSelect && $rollCounter != 0)
                        categoryArray[11].setTrue
                        textArray[11].color = 'red'
                        updateSums(di, categoryArray, textArray)
                    end
                when 'v'
                    if(!categoryArray[12].getSelect && $rollCounter != 0)
                        categoryArray[12].setTrue
                        textArray[12].color = 'red'
                        updateSums(di, categoryArray, textArray)
                    end
                when 'b'
                    if(!categoryArray[13].getSelect && $rollCounter != 0)
                        categoryArray[13].setTrue
                        textArray[13].color = 'red'
                        updateSums(di, categoryArray, textArray)
                    end
                when 'n'
                    if(!categoryArray[14].getSelect && $rollCounter != 0)
                        categoryArray[14].setTrue
                        textArray[14].color = 'red'
                        updateSums(di, categoryArray, textArray)
                    end
                when 'm'
                    if(!categoryArray[15].getSelect && $rollCounter != 0)
                        categoryArray[15].setTrue
                        textArray[15].color = 'red'
                        updateSums(di, categoryArray, textArray)
                    end     
            end
    end
show