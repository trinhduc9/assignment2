/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified: 15/08/2023
 Acknowledgement:
 */

import Foundation


class Card: Identifiable, ObservableObject, Codable {
    var id = UUID()
    @Published var isFaceUp = false
    @Published var isBomb = false
    var text: String
    
    init(text: String){
        self.text = text
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case isFaceUp
        case isBomb
        case text
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        isFaceUp = try container.decode(Bool.self, forKey: .isFaceUp)
        isBomb = try container.decode(Bool.self, forKey: .isBomb)
        text = try container.decode(String.self, forKey: .text)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(isFaceUp, forKey: .isFaceUp)
        try container.encode(isBomb, forKey: .isBomb)
        try container.encode(text, forKey: .text)
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
    while n < 16{
        cardList.append(Card(text: "💎"))
        n += 1
    }
    return cardList
}
