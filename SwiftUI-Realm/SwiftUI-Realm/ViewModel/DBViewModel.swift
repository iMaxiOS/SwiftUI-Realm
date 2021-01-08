//
//  DBViewModel.swift
//  SwiftUI-Realm
//
//  Created by Maxim Granchenko on 08.01.2021.
//

import SwiftUI
import RealmSwift

class DBViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var detail = ""
    @Published var isPresent = false
    
    @Published var cards: [Card] = []
    
    func addData() {
        let card = Card()
        card.title = title
        card.detail = detail
        
        guard let dbRef = try? Realm() else { return }
        
        try? dbRef.write {
            dbRef.add(card)
        }
    }
}
