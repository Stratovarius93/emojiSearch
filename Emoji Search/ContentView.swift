//
//  ContentView.swift
//  Emoji Search
//
//  Created by Juan Carlos Catagña Tipantuña on 17/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""

    private var searchResults: [EmojiDetails] {
        let results = EmojiProvider.all()
        if searchText.isEmpty {return results}
        return results.filter {
            $0.name.lowercased().contains(searchText.lowercased()) || $0.emoji.contains(searchText)
        }
    }
    
    private var suggestedResults: [EmojiDetails]{
        if searchText.isEmpty{return []}
        return searchResults
    }

    var body: some View {
        NavigationView {
            List(searchResults) {
                emojiDetail in
                NavigationLink(destination: EmojiDetailView(emojiDetail: emojiDetail)) {
                    Text("\(emojiDetail.emoji) \(emojiDetail.name)").padding(6)
                }
            }.navigationTitle("Emoji list")
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic),
                            prompt: "Search for emoji"){
                    ForEach(suggestedResults) { emojiDetails in
                        Text("Looking for\(emojiDetails.emoji)?")
                            .searchCompletion(emojiDetails.name)
                    }
                }
        }
    }
}

struct EmojiDetailView: View {
    let emojiDetail: EmojiDetails
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(emojiDetail.emoji) \(emojiDetail.name)")
                    .font(.largeTitle)
                    .bold()
                Text(emojiDetail.description)
                Spacer()
            }
            Spacer()
        }.padding([.leading, .trailing], 24)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
