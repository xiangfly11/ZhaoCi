//
//  MarkdownEditorView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/28.
//

import SwiftUI
import Ink

enum TextEditorType: Hashable {
    case titleType
    case contentType
}

struct MarkdownEditorView: View {
    @State private var selectedPage: Int = 0
    @State private var titleText: String = ""
    @State private var contentText: String = ""
    @FocusState private var focusedEditor: TextEditorType?
    @State private var forward: Bool = false
    @State private var backward: Bool = false
    @State private var showActionSheet = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
    private var noteModel: NoteModel?
    
    var html: String {
        var parser = MarkdownParser()
        let modifier = Modifier(target: .codeBlocks) { html, markdown in
            let codeBlock = setCodeBGBlock(with: .lightGray, html: html)
             return codeBlock
        }
        
        parser.addModifier(modifier)
        return parser.html(from: contentText)
    }
    
    var body: some View {
        relayoutSubviews()
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(leading: navItmes)
        .navigationBarBackButtonHidden(true)
    }
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    init(noteModel: NoteModel) {
        self.init()
        self.noteModel = noteModel
    }
}

extension MarkdownEditorView {
    private func relayoutSubviews() -> some View {
        return ZStack(alignment: .leading) {
            VStack {
                if selectedPage == MarkdownEditorType.editor.rawValue {
                    MarkdownTextView(markdownText: $contentText, title: $titleText)
                } else if selectedPage == MarkdownEditorType.preview.rawValue {
                    iOSPreview(html: html)
                }
                HStack {
                    VStack(alignment: .center) {
                        Spacer()
                        CustomPageControl(selectedPage: $selectedPage)
                            .frame(width: 150, height: 44)
                            .padding(.bottom, 10)
                    }
                }
                .frame(height: 44)
            }
            .background(selectedPage == MarkdownEditorType.editor.rawValue ? Color(UIColor.yunShuiLan) : Color(UIColor.yuDuBai))
        }
        .padding(.top)
        .background(.white)
        .onAppear {
            //@State 类型的变量似乎会随着View的出现而被重新创建
            //因此使用实例变量noteModel在创建MarkdownEditorView的时候存储值
            //当MarkdownEditorView现实的时候再将值赋值给 @State变量
            guard let note = noteModel else { return }
            titleText = note.titleStr
            contentText = note.contentStr
        }
    }
}

extension MarkdownEditorView {
    enum CodeBlockBGColor {
        case lightGray
        case darkGray
        case orange
        case blue
    }
    
    private func setCodeBGBlock(with theme: CodeBlockBGColor = .lightGray, html: String) -> String {
        var bgColor = "<p style=\"background-color:rgb(211,211,211);\">"
        switch theme {
        case .lightGray:
            break;
        case .darkGray:
            bgColor = "<p style=\"background-color:rgb(47,79,79);\">"
        case .orange:
            bgColor = "<p style=\"background-color:rgb(255,165,0);\">"
        case .blue:
            bgColor = "<p style=\"background-color:rgb(135,206,235);\">"
        }
        
        let newCodeBlock1 = html.replacingOccurrences(of: "<code>", with: bgColor)
        let newCodeBlock2 = newCodeBlock1.replacingOccurrences(of: "</code>", with: "</p>")
        return newCodeBlock2
    }
    
    private func finished() {
        
    }
    
    private func saveNote(noteType: ListType) {
        do {
            let task = Note(context: viewContext)
            task.title = titleText
            task.content = contentText
            task.createDate = Date()
            task.noteType = noteType.rawValue
            task.noteId = Int64(Date().timeIntervalSince1970)
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        popVC()
    }
    
    private func popVC() {
        self.presentationMode.wrappedValue.dismiss()
        EditorRecord.shared.cleanCache()
    }
}

extension MarkdownEditorView {
    var navItmes: some View {
        HStack(alignment: .center, spacing: 20) {
            Button {
                guard titleText.count > 0, contentText.count > 0 else {
                    self.popVC()
                    return
                }
                showActionSheet = true
            } label: {
                Text("完成")
                    .foregroundColor(.green)
                    .font(.WenKaiMonoBold(size: 18))
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("是否存储笔记"),
                                   message: Text("请选择笔记存储类型"),
                                   buttons: [
                                       .cancel(),
                                       .default(
                                           Text("笔记")
                                            .font(Font.WenKaiMonoBold(size: 18)),
                                           action: {
                                               saveNote(noteType: .notes)
                                           }
                                       ),
                                       .default(Text("草稿")
                                        .font(Font.WenKaiMonoBold(size: 18)), action: {
                                           saveNote(noteType: .drafts)
                                       }),
                                       .default(Text("退出"), action: {
                                           self.popVC()
                                       }),
                                       .destructive(Text("垃圾箱")
                                        .font(Font.WenKaiMonoBold(size: 18)), action: {
                                           saveNote(noteType: .trash)
                                       })
                                   ]
                       )
            }
            
            Button {
                let backwardText = EditorRecord.shared.backward()
                contentText = backwardText
            } label: {
                if EditorRecord.shared.backwardAvailable == true {
                    Image(systemName: "arrow.uturn.backward.circle.fill")
                        .tint(.green)
                } else {
                    Image(systemName: "arrow.uturn.backward.circle.fill")
                        .tint(.gray)
                }
            }
            
            Button {
                let forwardText = EditorRecord.shared.forward()
                contentText = forwardText
            } label: {
                if EditorRecord.shared.forwardAvailable == true {
                    Image(systemName: "arrow.uturn.forward.circle.fill")
                        .tint(.green)
                } else {
                    Image(systemName: "arrow.uturn.forward.circle.fill")
                        .tint(.gray)
                }
               
            }

            Button {
                
            } label: {
               Image(systemName: "square.and.arrow.up")
                    .tint(.green)
            }
            
//            switch self.selectedType {
//            case .preview:
//                Button {
//                    self.selectedType = .editor
//                } label: {
//                    Image(systemName: "eye.slash")
//                        .tint(.gray)
//                }
//            case .editor:
//                Button {
//                    self.selectedType = .preview
//                } label: {
//                    Image(systemName: "eye")
//                        .tint(.green)
//                }
//            }

            Button {
                
            } label: {
                Text("更多")
                    .foregroundColor(.green)
                    .font(.WenKaiMonoBold(size: 18))
            }

        }
        .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
    }
}

struct MarkdownEditorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MarkdownEditorView()
        }
    }
}
