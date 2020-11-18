//
//  ContentView.swift
//  TabTest
//
//  Created by Maksym Kulyk on 11/18/20.
//

import SwiftUI

struct Page : View
{
    let id:Int
    @State var count = 0
    var body: some View {
        Text("test")
            .onAppear
            {
                count += 1
                print("View\(id) appeared \(count)")
            }
    }
}

struct WrapperView<Content>: View where Content: View
{
    let title:String
    let content : () -> Content
    
    var body: some View
    {
        ZStack
        {
            
            VStack
            {
                Text(title)
                content()
            }
        }
    }
}

struct ContentView: View {
    @State var selection = 0
    
    let w_view = UUID()
    let tab_view = UUID()
    
    let p0_view = UUID()
    let p1_view = UUID()
    let p2_view = UUID()
    
    func get_title(_ s:Int) -> String
    {
        switch s {
        case 0,1,2:
            return "title \(s)"
        default:
            return "Out of bounds \(s)"
        }
    }
    
    var body: some View {
        WrapperView(title: get_title(selection))
        {
            TabView(selection: $selection)
            {
                Page(id: 0)
                    .tag(0)
                    .id(p0_view)
                Page(id: 1)
                    .tag(1)
                    .id(p1_view)
                Page(id: 2)
                    .tag(2)
                    .id(p2_view)
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .id(tab_view)
        }.id(w_view)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
