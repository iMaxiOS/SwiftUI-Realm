//
//  Home.swift
//  SwiftUI-Realm
//
//  Created by Maxim Granchenko on 08.01.2021.
//

import SwiftUI

struct Home: View {
    
    @StateObject var bdModel = DBViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                
            })
            .navigationTitle("Realm DB")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        bdModel.isPresent.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .renderingMode(.template)
                            .foregroundColor(Color(.systemBlue))
                    })
                    .sheet(isPresented: $bdModel.isPresent, content: {
                        Detail()
                            .environmentObject(bdModel)
                    })
                }
            })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
