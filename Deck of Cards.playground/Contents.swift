import UIKit

struct Card {
    enum Color: String {
        case Red = "Red", Blue = "Blue", Green = "Green"
    }
    let color: Color
    let roll: Int
    init(roll: Int) {
        self.roll = roll
        switch roll {
        case 1, 2:
            self.color = .Blue
        case 3:
            self.color = .Red
        case 4:
            let number = Int.random(in: 0...1)
            if number == 0 {
                self.color = .Red
            } else {
                self.color = .Green
            }
        case 5, 6:
            self.color = .Green
        default:
            fatalError("roll needs to be 1 to 6")
        }
    }
}
class Deck {
    var cards: [Card] = []
    let numberOfCards: Int = 30
    init(){
        for _ in 1...10 {
            let card: Card = Card(roll: Int.random(in: 1...2))
            cards.append(card)
        }
        for _ in 1...10 {
            let card: Card = Card(roll: Int.random(in: 3...4))
            cards.append(card)
        }
        for _ in 1...10 {
            let card: Card = Card(roll: Int.random(in: 4...6))
            cards.append(card)
        }
    }
    func deal() -> Card {
        if cards.isEmpty == false {
            let topCard: Card? = cards.last
            cards.removeLast()
            return topCard!
        }else{
             fatalError("the Deck is empty")
        }
    }
    func isEmpty() -> Bool{
        if cards.count == 0 {
            return true
        }else{
            return false
        }
    }
    func shuffle (){
        if cards.count <= 1 {
            fatalError("cannot shuffle the deck has 1 card or empty")
        }else{
            for _ in 0...cards.count-1{
                var temp: Card
                let randomNum = Int.random(in: 0...cards.count-1)
                let randomNum2 = Int.random(in: 0...cards.count-1)
                temp = cards[randomNum]
                cards[randomNum] = cards[randomNum2]
                cards[randomNum2] = temp
            }
        }
    }
        
}
class Player{
    let name: String
    var hand: [Card] = []
    init(name: String) {
        self.name = name
    }
    func Draw(_: Deck) -> Card {
        let pCard = Deck().deal()
        hand.append(pCard)
        return pCard
    }
    func RollDice() -> Int {
        let dice = Int.random(in: 1...6)
        return dice
    }
    func MatchingCards(cardColor :String, cardRoll :Int) -> Int {
        let cardClr =  cardColor
        let cardRl = cardRoll
        var matchCounter = 0
        let range = hand.count - 1
        for i in 0...range {
            if cardRl == hand[i].roll || cardClr == hand[i].color.rawValue  {
                matchCounter += 1
            }
        }
        return matchCounter
    }
}

let deck: Deck = Deck()
deck.shuffle()
let plYr: Player = Player(name: "rawan")
for _ in 0...3 {
    plYr.Draw(deck)
}
for i in 0...plYr.hand.count-1 {
    print ("color: ",plYr.hand[i].color.rawValue," roll:  ",plYr.hand[i].roll)
}
print(plYr.MatchingCards(cardColor: "Red", cardRoll: 2))
