
class ScoreCalculator
    public
    def upperSums(targetNum, diceArray)
        score = 0
        diceArray.each { |dice|
        
            if dice.getvalue == targetNum
                score += targetNum
            end
        }
        return score;
    end

    def chance(diceArray)
        score = 0
        diceArray.each() {|dice|
            score+= dice.getvalue
        }
        return score;
    end

    def lowerStraight(diceArray)
    
        score = 0
        diceArray.each() {|dice|j
        }

    end
end