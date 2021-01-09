//
//  Detail.swift
//  SwiftUI-Realm
//
//  Created by Maxim Granchenko on 08.01.2021.
//

import SwiftUI

struct Detail: View {
    
    @EnvironmentObject var dbModel: DBViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Title")) {
                    TextField("", text: $dbModel.title)
                }
                
                Section(header: Text("Detail")) {
                    TextField("", text: $dbModel.detail)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(dbModel.updateObject == nil ? "Add Data" : "Update")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dbModel.addData(presentation: presentationMode)
                    }, label: {
                        Text("Done")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
            }
        }
        .onAppear(perform: dbModel.setUpInitialData)
        .onDisappear(perform: dbModel.deInitData)
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail()
    }
}
