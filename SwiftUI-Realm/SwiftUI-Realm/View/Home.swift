//
//  Home.swift
//  SwiftUI-Realm
//
//  Created by Maxim Granchenko on 08.01.2021.
//

import SwiftUI

struct Home: View {
    
    @StateObject var dbModel = DBViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 15) {
                    ForEach(dbModel.cards) { card in
                        VStack(alignment: .leading, spacing: 3) {
                            Text(card.title)
                                .font(.title3)
                                .fontWeight(.heavy)
                                .foregroundColor(Color(.systemGray))
                            Text(card.detail)
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(Color(.systemGray3))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(Color(.gray).opacity(0.15))
                        .cornerRadius(10)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .contextMenu(ContextMenu(menuItems: {
                            Button(action: {
                                dbModel.deleteItem(object: card)
                            }, label: {
                                Text("Delete item")
                            })
                            
                            Button(action: {
                                dbModel.updateObject = card
                                dbModel.isPresent.toggle()
                            }, label: {
                                Text("Update item")
                            })
                        }))
                    }
                }
                .padding()
            })
            .navigationTitle("Realm DB")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dbModel.isPresent.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .renderingMode(.template)
                            .foregroundColor(Color(.systemBlue))
                    })
                }
            })
            .sheet(isPresented: $dbModel.isPresent, content: {
                Detail()
                    .environmentObject(dbModel)
            })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
