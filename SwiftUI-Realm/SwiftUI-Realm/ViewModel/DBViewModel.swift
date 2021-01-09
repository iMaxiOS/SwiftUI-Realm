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
        guard let dbRef = try? Realm() else{ return }
        
        let results = dbRef.objects(Card.self)
        self.cards = results.compactMap({ (card) -> Card? in
            return card
        })
    }
    
    func addData(presentation: Binding<PresentationMode>) {
        if title == "" || detail == "" { return }
        
        let card = Card()
        card.title = title
        card.detail = detail
        
        guard let dbRef = try? Realm() else{return}
        
        try? dbRef.write {
            guard let availableObject = updateObject else {
                dbRef.add(card)
                return
            }
            
            availableObject.title = title
            availableObject.detail = detail
        }
        
        fetchData()
        presentation.wrappedValue.dismiss()
    }
    
    func deleteItem(object: Card) {
        guard let dbRef = try? Realm() else{return}
        
        try? dbRef.write {
            dbRef.delete(object)
            fetchData()
        }
    }
    
    func setUpInitialData() {
        guard let updateData = updateObject else{ return }
        title = updateData.title
        detail = updateData.detail
    }
    
    func deInitData() {
        updateObject = nil
        title = ""
        detail = ""
    }
}
