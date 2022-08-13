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
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "createDate", ascending: false)]) private var allNotes: FetchedResults<Note>
    @Environment(\.managedObjectContext) private var noteContext
    
    private var paddingEdgeInset = EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $selectedIndex) {
                    ForEach(ListType.allCases) { type in
                        Text(type.listTypeName)
                            .tag(type.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(paddingEdgeInset)
               
                List {
                    ForEach(allNotes) { note in
                        Text(note.title ?? "")
                    }
                    .onDelete { indexSet in
                        deleteNote(atOffsets: indexSet)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

extension NoteListView {
    func searchNote() {
        searchTitleFocused = false
    }
    
    func deleteNote(atOffsets: IndexSet) {
        for offset in atOffsets {
            let note = allNotes[offset]
            noteContext.delete(note)
        }
        
        do {
            try noteContext.save()
        } catch {
            print("save context failed \(error.localizedDescription)")
        }
        
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView()
    }
}
