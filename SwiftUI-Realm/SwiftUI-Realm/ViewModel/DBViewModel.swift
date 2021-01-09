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
    
    @Published var updateObject: Card?
    @Published var cards: [Card] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let dbRef = try? Realm() else { return }
        
        let result = dbRef.objects(Card.self)
        
        self.cards = result.compactMap { card in
            return card
        }
    }
    
    func addData(presentation: Binding<PresentationMode>) {
        let card = Card()
        card.title = title
        card.detail = detail
        
        guard let dbRef = try? Realm() else { return }
        
        try? dbRef.write {
            guard let availableItem = updateObject else {
                dbRef.add(card)
                return
            }
            
            availableItem.title = title
            availableItem.detail = detail
        }
        
        fetchData()
        presentation.wrappedValue.dismiss()
    }
    
    func deleteItem(item: Card) {
        guard let dbRef = try? Realm() else { return }
        
        try? dbRef.write {
            dbRef.delete(item)
            fetchData()
        }
    }
    
    func setUpInitialData() {
        guard let updateItem = updateObject else { return }
        
        title = updateItem.title
        detail = updateItem.detail
    }
    
    func deInitData() {
        title = ""
        detail = ""
    }
}
