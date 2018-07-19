//
//  ViewController.swift
//  Concentration
//
//  Created by Alex Ruber on 6/28/18.
//  Copyright © 2018 Alex Ruber. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
            // Read only
            return (cardButtons.count+1) / 2
    }
    
    var flipCount: Int = 0 {
        didSet {
            numberOfFlips.text = "\(flipCount) Flips"
        }
    }
    @IBOutlet weak var numberOfFlips: UILabel!
    
    
    @IBAction func didTapNewGame(_ sender: Any) {
        Card.identifierFactory = 0
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1) / 2)
    }
    
    
    @IBAction func didTapCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Error")
        }
        
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setTitle(emoji(for: card), for: .normal)
            } else {
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.setTitle("", for: .normal)
            }
        }
    }
    
    var emojiChoices = ["👻", "🎃", "😎", "😍", "😇", "😡", "🤢", "👾"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        
        guard let chosenEmoji = emoji[card.identifier] else { return "?"}
        return chosenEmoji
    }
    
    
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

