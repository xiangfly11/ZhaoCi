//
//  NoteListView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/27.
//

import SwiftUI

struct NoteListView: View {
    @State private var searchedTitle: String = ""
    @FocusState private var searchTitleFocused: Bool
    @State private var selectedIndex: Int = ListType.notes.rawValue
    private var paddingEdgeInset = EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
    var body: some View {
        VStack {
//            TextField("Search Note Title", text: $searchedTitle)
//              .focused($searchTitleFocused)
//              .submitLabel(.done)
//              .onSubmit({
//                  searchNote()
//              })
//              .frame(height: 30)
//              .bordered()
//              .padding(paddingEdgeInset)
            
            Picker("", selection: $selectedIndex) {
                ForEach(ListType.allCases) { type in
                    Text(type.listTypeName)
                        .tag(type.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(paddingEdgeInset)
            
            HStack {
                Text("\(ListType.listName(index: selectedIndex))")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.leading, 10)
                Spacer()
            }
           
            List {
                
            }
        }
    }
}

extension NoteListView {
    func searchNote() {
        searchTitleFocused = false
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView()
    }
}
