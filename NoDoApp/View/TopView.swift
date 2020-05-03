//
//  TopView.swift
//  NoDoApp
//
//  Created by Supannee Mutitanon on 3/5/20.
//  Copyright © 2020 Supannee Mutitanon. All rights reserved.
//

import SwiftUI

struct TopView: View {
    @Binding var nodoItem: NoDo
    @State var placeHolder = "Add Something"
    @Binding var showField: Bool
    @Binding var nodoList: [NoDo]
    
    var body: some View {
        ZStack {
            ZStack(alignment: .leading) {
                TextField(self.placeHolder, text: self.$nodoItem.name){
                    self.nodoList.insert(NoDo(name: self.nodoItem.name, isDone: false), at: 0)
                    self.nodoItem.name = "" //clear textfield
                    self.save()
                    print(self.nodoList)
                }.padding(.all, 10)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .offset(x: showField ? 0 : -UIScreen.main.bounds.width/2 - 180)
                    .animation(.spring())
                
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                        .offset(x: self.showField ? UIScreen.main.bounds.width - 95 : -35)
                        .animation(.spring())
                        .onTapGesture {
                            self.showField.toggle()
                }
            }.padding(.bottom, 20)
                .padding(.leading, 3)
        }
    }
    
    func save() {
        guard let data = try? JSONEncoder().encode(self.nodoList) else { return }
        UserDefaults.standard.set(data, forKey: "nodos")
    }
}

//struct TopView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopView()
//    }
//}

