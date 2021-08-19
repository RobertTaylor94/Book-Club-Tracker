//
//  StatsView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 28/07/2021.
//

import SwiftUI

struct StatsView: View {
    
    @ObservedObject var viewModel = StatsViewModel()

    var body: some View {
        
        NavigationView {
            VStack(spacing: 30) {
                //Graph at top of weekly reading
                Spacer()
                //Timer to track current reading session
                NavigationLink(
                    destination: TimerView(),
                    label: {
                        Text("Read Now")
                            .padding()
                            .font(.title)
                            .background(Color("Button"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    })
                //Previous book time length to read
                if viewModel.books != nil {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.books!.reversed()) { i in
                                BookStatsView(
                                    bookImgUrl: i.imgurl,
                                    bookTitle: i.title,
                                    bookAuthor: i.authors,
                                    totalPages: "\(i.pageCount)",
                                    timeToRead: i.timeToRead
                                )
                            }
                        }
                    }
                    .padding()
                    .onAppear(){
                        viewModel.updateBooks()
                    }
                } else {
                    Text("No stats available")
                        .onAppear(){
                            viewModel.updateBooks()
                        }
                }
            }//VstackEnd
            .navigationTitle("Stats")
        }//NavStackEnd
    }

}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
