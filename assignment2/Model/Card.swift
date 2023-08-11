/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified:
 Acknowledgement:
 */

import Foundation

class Card: Identifiable, ObservableObject {
    var id = UUID()
    @Published var isFaceUp = false
    @Published var isBomb = false
    var text: String
    
    init(text:String){
        self.text =  text
    }
    
    func turnCard(){
        self.isFaceUp.toggle()
    }
}

func createList(bombNo: Int) -> [Card] {
    
    var cardList = [Card]()
    var n = 0
    for i in 1...bombNo {
        cardList.append(Card(text: "💣"))
        n += 1
    }
    while n < 25{
        cardList.append(Card(text: "💰"))
        n += 1
    }
    return cardList
}
