//
//  Card.swift
//  SwiftUI-Realm
//
//  Created by Maxim Granchenko on 08.01.2021.
//

import Foundation
import RealmSwift

class Card: Object, Identifiable {
    @objc dynamic var id: Date = Date()
    @objc dynamic var title = ""
    @objc dynamic var detail = ""
}
