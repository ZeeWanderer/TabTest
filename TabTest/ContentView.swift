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
    var body: some View {
        Text("View\(id)")
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
    @State var count = 0
    @State var count_tab_view = 0
    
    @State var count_v0 = 0
    @State var count_v1 = 0
    @State var count_v2 = 0
    
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
                    .onAppear
                    {
                        count_v0 += 1
                        print("View0 appeared \(count_v0)")
                    }
                Page(id: 1)
                    .onAppear
                    {
                        count_v1 += 1
                        print("View1 appeared \(count_v1)")
                    }
                Page(id: 2)
                    .onAppear
                    {
                        count_v2 += 1
                        print("View2 appeared \(count_v2)")
                    }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .id(tab_view)
            .onAppear
            {
                count_tab_view += 1
                print("TabView appeared \(count_tab_view)")
            }
        }.id(w_view)
        .onAppear
        {
            count += 1
            print("WrapperView appeared \(count)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
