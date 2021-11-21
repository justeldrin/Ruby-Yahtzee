class ScoreCalculator
    
    def initialize()
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
        counter.each {|key, value|
                if(value == 3)
                    score = key * 3
                end
        }
        return score
    end

    def fourKind(diceArray)
        scoreArray = valueArray(diceArray)
        score = 0
        counter = scoreArray.tally
        counter.each {|key, value|
                if(value == 4)
                    score = key * 4
                end
        }
        return score
    end

    def fullHouse(diceArray)
        scoreArray = valueArray(diceArray)
        score = 0
        counter = scoreArray.tally
        counter.each {|key, value|
                if(value == 2)
                    score += key * 2
                elsif(value == 3)
                    score += key * 3
                end
        }
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
                    score = key * 5
                end
        }
        return score
    end

    def chance(diceArray)
        scoreArray = valueArray(diceArray)
        score = 0
        scoreArray.each() {|dice|
            score+= dice.getvalue
        }
        return score;
    end

    def valueArray(diceArray)
        array = Array.new(5)
        for i in 0..5
            array[i] == diceArray[i].getScore
        end  
   
        return array
    end
end