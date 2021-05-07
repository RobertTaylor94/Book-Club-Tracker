//
//  GroupsView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 07/05/2021.
//

import SwiftUI
import FirebaseAuth

struct GroupsView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                //Firebase login/signup
                    
                }, label: {
                    Text("Sign-In")
                })
            }
            .padding()
            
            Spacer()
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}
