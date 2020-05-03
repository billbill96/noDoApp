//
//  CellRow.swift
//  NoDoApp
//
//  Created by Supannee Mutitanon on 3/5/20.
//  Copyright © 2020 Supannee Mutitanon. All rights reserved.
//

import SwiftUI

struct CellRow: View {
    @State var noDoItem: NoDo
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Group {
                HStack {
                    Text(noDoItem.name)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    Spacer()
                    
                    Image(systemName: noDoItem.isDone ? "checkmark" : "square")
                    .padding()
                }
                HStack(alignment: .center, spacing: 8) {
                    Spacer()
                    Text("Added: \(noDoItem.dateText)")
                        .foregroundColor(.white)
                        .italic()
                        .padding(.all, 5)
                }.padding(.bottom, 5)
            }.padding(.all, 4)
        }.blur(radius: noDoItem.isDone ? 1 : 0)
        .opacity(noDoItem.isDone ? 0.7 : 1)
        .background(noDoItem.isDone ? Color.gray : Color.pink)
        .clipShape(RoundedRectangle(cornerRadius: 5))
            .onTapGesture {
                self.noDoItem.isDone.toggle()
        }
        .animation(.spring())
        .offset(x: self.noDoItem.isDone ? -34 : 0)
    }
}

//struct CellRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CellRow()
//    }
//}
