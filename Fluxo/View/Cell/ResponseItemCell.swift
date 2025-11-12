//
//  RequestItemCell.swift
//  Fluxo
//
//  Created by Darktt on 2025/11/12.
//

import SwiftUI

public
struct ResponseItemCell: View
{
    public
    typealias ActionHandler = (ResponseItem) -> Void
    
    public
    let requestItem: ResponseItem
    
    public
    let deleteAction: ActionHandler?
    
    public
    let editAction: ActionHandler?
    
    private
    var methodColor: Color {
        
        let method = self.requestItem.method
        if method == .get {
            
            return .green
        }
        
        if method == .post {
            
            return .red
        }
        
        return .blue
    }
    
    @State
    private
    var isHovered: Bool = false
    
    public
    var body: some View {
        
        VStack(spacing: 10.0) {
            
            HStack(spacing: 5.0) {
                
                Text(self.requestItem.path)
                    .font(.title3.bold())
                    .padding(.horizontal, 10.0)
                
                Spacer()
                
                if !self.requestItem.path.isEmpty {
                    
                    if self.isHovered {
                        
                        self.deleteAndEditButton()
                    }
                    
                    Text(self.requestItem.method.rawValue.uppercased())
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(self.methodColor)
                        .padding(.horizontal, 10.0)
                }
            }
            
            Rectangle()
                .fill(Color.secondary.opacity(0.5))
                .frame(height: 1.0)
        }
        .contentShape(Rectangle())
        .onHover{
            
            self.isHovered = $0
        }
        .animation(.easeInOut(duration: 0.25), value: self.isHovered)
        .frame(height: 30.0)
        .padding(.top, 10.0)
        .padding(.bottom, 0.0)
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public
    init(requestItem: ResponseItem, deleteAction: ActionHandler? = nil, editAction: ActionHandler? = nil)
    {
        self.requestItem = requestItem
        self.deleteAction = deleteAction
        self.editAction = editAction
    }
}

extension ResponseItemCell
{
    private
    func deleteAndEditButton() -> some View {
        
        HStack(spacing: 5.0) {
            
            Button {
                
                self.deleteAction?(self.requestItem)
            } label: {
                
                Image(systemName: "trash")
                    .foregroundColor(.white)
            }
            .background(.red.opacity(0.6))
            .clipShape(.capsule)
            
            Button {
                
                self.editAction?(self.requestItem)
            } label: {
                
                Image(systemName: "long.text.page.and.pencil.fill")
                    .foregroundColor(.white)
            }
            .background(.gray.opacity(0.3))
            .clipShape(.capsule)
        }
        .frame(height: 20.0)
    }
}

// MARK: ResponseItemCell.Title

extension ResponseItemCell
{
    public
    struct Title: View
    {
        public
        var body: some View {
            
            HStack(spacing: 10.0) {
                
                Text("Path")
                    .frame(width: 60, alignment: .center)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10.0)
                
                Spacer()
                
                Text("Method")
                    .frame(width: 60, alignment: .center)
                    .padding(.horizontal, 50.0)
            }
            .frame(height: 20.0)
            .background(Color.gray.opacity(0.2))
        }
    }
}

#Preview("Title") {
    
    ResponseItemCell.Title()
        .frame(height: 60.0)
}

#Preview("Get") {
    
    ResponseItemCell(requestItem: ResponseItem.defaultItem())
        .frame(height: 60.0)
}

#Preview("Post") {
    
    ResponseItemCell(requestItem: ResponseItem.defaultItem(with: .post))
        .frame(height: 60.0)
}

#Preview("Others") {
    
    ResponseItemCell(requestItem: ResponseItem.defaultItem(with: .put))
        .frame(height: 60.0)
}

#Preview("Empty Path") {
    
    ResponseItemCell(requestItem: ResponseItem.empty())
        .frame(height: 60.0)
}
