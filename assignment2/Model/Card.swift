/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified: 22/08/2023
 Acknowledgement:
-   https://www.youtube.com/watch?v=VYxxzrlS8q0
-   https://www.youtube.com/watch?v=aJ9kKX6Ak3k
-	https://kowei-chen.medium.com/swiftui-dynamic-localization-tricks-87c37a6db3e7
-	https://www.hackingwithswift.com/quick-start/swiftui/how-to-provide-relative-sizes-using-geometryreader
-	https://stackoverflow.com/questions/62372188/how-to-use-userdata-observable-object-in-swiftui
-	https://www.hackingwithswift.com/quick-start/swiftui/how-to-disable-taps-for-a-view-using-allowshittesting
-	https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-a-menu-when-a-button-is-pressed
-	https://developer.apple.com/documentation/swiftui/picker
-	https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-views-in-a-grid-using-lazyvgrid-and-lazyhgrid
 */

import Foundation

//Struct for Card
class Card: Identifiable, ObservableObject, Codable {
    var id = UUID()
    @Published var isFaceUp = false
    var text: String
    
    init(text: String){
        self.text = text
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case isFaceUp
        case text
    }
    
    // Decoding initializer
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        isFaceUp = try container.decode(Bool.self, forKey: .isFaceUp)
        text = try container.decode(String.self, forKey: .text)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(isFaceUp, forKey: .isFaceUp)
        try container.encode(text, forKey: .text)
    }
    
    //Function to faceup the card
    func turnCard(){
        self.isFaceUp.toggle()
    }
}

//Create the list for the game
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
