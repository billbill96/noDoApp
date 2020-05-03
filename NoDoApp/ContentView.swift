//
//  ContentView.swift
//  NoDoApp
//
//  Created by Supannee Mutitanon on 3/5/20.
//  Copyright © 2020 Supannee Mutitanon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var nodoList: [NoDo] = {
        guard let data = UserDefaults.standard.data(forKey: "nodos") else { return [] }
        if let json = try? JSONDecoder().decode([NoDo].self, from: data) {
            return json
        }
        return []
    }()
    
    @State var showField: Bool = false
    @State var nodoItem = NoDo()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 8) {
                    TopView(nodoItem: self.$nodoItem,
                            showField: $showField,
                            nodoList: $nodoList)
                }
                List {
                    ForEach(nodoList, id: \.id) { item in
                        CellRow(noDoItem: item)
                    }.onDelete(perform: deleteItem)
                }
            }.navigationBarTitle("NODO")
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        guard let index = Array(offsets).first else { return }
        print("removing \(nodoList[index])")
        nodoList.remove(at: index)
        save()
    }
    
    func save() {
        guard let data = try? JSONEncoder().encode(self.nodoList) else { return }
        UserDefaults.standard.set(data, forKey: "nodos")
    }
}
//struct ContentView: View {
//    @State var nodo: String = ""
//    @State var nodoList: [String] = []
//    @State var timeAgo: String = ""
//    var body: some View {
//        NavigationView {
//            VStack {
//                HStack(spacing: 8) {
//                    Image(systemName: "plus.circle")
//                        .padding(.leading)
//                    Group() {
//                        TextField("What you will you not do today?", text: $nodo, onEditingChanged: { (changed) in
//                            print(changed)
//                        }) {
//                            self.timeAgo = self.timeAgoSinceDate(Date())
//                            self.nodoList.insert(self.nodo, at: 0)
//                            print("all item \(self.nodoList)")
//                            self.nodo = "" //clear textfield
//                        }.padding(.all, 12)
//                    }.background(Color.green)
//                        .clipShape(RoundedRectangle(cornerRadius: 5))
//                        .shadow(radius: 5)
//                        .padding(.trailing, 8)
//                }
//
//                List() {
//                    ForEach(nodoList, id: \.self) { list in
//                        NoDoRow(noDoItem: list, timeAgo: self.timeAgo)
//                    }.onDelete(perform: deleteItem(at:))
//                }
//            }.navigationBarTitle("NODO")
//        }
//    }
//
//    func deleteItem(at offsets: IndexSet) {
//        guard let index = Array(offsets).first else { return }
//        print("removing \(nodoList[index])")
//        nodoList.remove(at: index)
//    }
//
//    func formatDate(_ date: Date) -> String {
//        let date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .full
//
//        return dateFormatter.string(from: date)
//    }
//
//    func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String {
//
//          //source: https://gist.github.com/minorbug/468790060810e0d29545
//
//          let calendar = NSCalendar.current
//          let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
//          let now = Date()
//          let earliest = now < date ? now : date
//          let latest = (earliest == now) ? date : now
//          let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
//
//          if (components.year! >= 2) {
//              return "\(components.year!) years ago"
//          } else if (components.year! >= 1){
//              if (numericDates){
//                  return "1 year ago"
//              } else {
//                  return "Last year"
//              }
//          } else if (components.month! >= 2) {
//              return "\(components.month!) months ago"
//          } else if (components.month! >= 1){
//              if (numericDates){
//                  return "1 month ago"
//              } else {
//                  return "Last month"
//              }
//          } else if (components.weekOfYear! >= 2) {
//              return "\(components.weekOfYear!) weeks ago"
//          } else if (components.weekOfYear! >= 1){
//              if (numericDates){
//                  return "1 week ago"
//              } else {
//                  return "Last week"
//              }
//          } else if (components.day! >= 2) {
//              return "\(components.day!) days ago"
//          } else if (components.day! >= 1){
//              if (numericDates){
//                  return "1 day ago"
//              } else {
//                  return "Yesterday"
//              }
//          } else if (components.hour! >= 2) {
//              return "\(components.hour!) hours ago"
//          } else if (components.hour! >= 1){
//              if (numericDates){
//                  return "1 hour ago"
//              } else {
//                  return "An hour ago"
//              }
//          } else if (components.minute! >= 2) {
//              return "\(components.minute!) minutes ago"
//          } else if (components.minute! >= 1){
//              if (numericDates){
//                  return "1 minute ago"
//              } else {
//                  return "A minute ago"
//              }
//          } else if (components.second! >= 3) {
//              return "\(components.second!) seconds ago"
//          } else {
//              return "Just now"
//          }
//      }
//
//}
//
//struct NoDoRow: View {
//    @State var noDoItem: String = ""
//    @State var isDone = false
//    @State var timeAgo: String = ""
//
//    var body: some View {
//        VStack(alignment: .center, spacing: 2) {
//            Group {
//                HStack {
//                    Text(noDoItem)
//                        .foregroundColor(.white)
//                        .multilineTextAlignment(.leading)
//                        .lineLimit(2)
//                        .padding(.leading, 8)
//                    Spacer()
//                    Image(systemName: self.isDone ? "checkmark" : "square")
//                        .padding()
//                }
//                HStack(alignment: .center, spacing: 3) {
//                    Spacer()
//                    Text("Added: \(timeAgo)")
//                        .foregroundColor(.white)
//                        .italic()
//                        .padding(.all, 8)
//                }.padding(.bottom, 5)
//            }.padding(.all, 8)
//        }.opacity(isDone ? 0.3 : 1)
//        .background(self.isDone ? Color.gray: Color.pink)
//        .clipShape(RoundedRectangle(cornerRadius: 5))
//            .padding(.all, 4)
//            .onTapGesture {
//                self.isDone.toggle()
//                print("\(self.isDone)")
//        }
//    }
//
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
