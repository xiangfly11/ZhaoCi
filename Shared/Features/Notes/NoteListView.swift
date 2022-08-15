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
    @State private var selectedIndex: Int16 = ListType.all.rawValue
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "createDate", ascending: false)]) private var allNotes: FetchedResults<Note>
    @Environment(\.managedObjectContext) private var noteContext
    
    private var paddingEdgeInset = EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
    
    private var notesType: [ListType] {
        let allNoteTypes = matchedNotes(type: selectedIndex).map({ $0.noteType })
        let notesTypes = Array(Set(allNoteTypes)).sorted()
        let listTypes = notesTypes.map({ ListType(rawValue: $0) ?? .notes })
        
        return listTypes
    }
    
    var body: some View {
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
                //特别注意ForEach 会通过模型的Identifiable 协议的id属性去判断不同的模型，因此一定要使用不同的id数字，如果所有的id都返回0，那么就只会有一个模型被重复使用
                ForEach(notesType) { type in
                    Section(header: Text(type.listTypeName)) {
                        ForEach(matchedNotes(type: type.rawValue)) { note in
                            NavigationLink(destination: MarkdownEditorView(noteModel: note)) {
                                Text(note.titleStr)
                            }
                        }
                        .onDelete { indexSet in
                            deleteNote(type: type, atOffsets: indexSet)
                        }
                    }
                }
            }
        }
    }
}

extension NoteListView {
    func searchNote() {
        searchTitleFocused = false
    }
    
    func deleteNote(type: ListType, atOffsets: IndexSet) {
        for offset in atOffsets {
            let matchedNotes = matchedNotes(type: type.rawValue)
            let noteModel = matchedNotes[offset]
            guard let note = allNotes.first(where: { $0.noteId == noteModel.noteId }) else { return }
            noteContext.delete(note)
        }
        
        do {
            try noteContext.save()
        } catch {
            print("save context failed \(error.localizedDescription)")
        }
        
    }
    
    private func matchedNotes(type: Int16) -> [NoteModel] {
        let matchNotes = allNotes.map({ NoteModel(titleStr: $0.title ?? "", contentStr: $0.content ?? "", noteId: $0.noteId, createDate: $0.createDate ?? Date(), noteType: $0.noteType)})
        let noteType = ListType(rawValue: type)
        switch noteType {
        case .all, .none:
            return matchNotes
        case .notes:
            return matchNotes.filter({ $0.noteType == ListType.notes.rawValue })
        case .drafts:
            return matchNotes.filter({ $0.noteType == ListType.drafts.rawValue })
        case .trash:
            return matchNotes.filter({ $0.noteType == ListType.trash.rawValue })
        }
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView()
    }
}
