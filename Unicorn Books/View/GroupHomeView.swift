//
//  GroupsView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 07/05/2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct GroupHomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                ScrollView(.horizontal) {
                    VStack(spacing: 20) {
                        Text("Group One")
                        NavigationLink(
                            destination: GroupView(),
                            label: {
                                Text("Navigate")
                            })
                    }
                    .frame(minWidth: 100, idealWidth: 200, maxWidth: 200, minHeight: 175, idealHeight: 350, maxHeight: 350)
                    .foregroundColor(.white)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color("BookTileColorTwo"), Color("BookTileColorOne")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(20)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("My Groups")
            .toolbar {
                Button(action: {
                    
                }, label: {
                    Text("Sign In")
                })
            }
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupHomeView()
    }
}
