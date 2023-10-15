//
//  ContentView.swift
//  HuliPizza
//
//  Created by Satish Thakur on 30/09/23.
//

import SwiftUI

struct ContentView: View {
    var menu: [MenuItem]
    @StateObject var orders:OrderModel = OrderModel()
    @State private var showOrders:Bool = false
    @State private var selectedItem: MenuItem = noMenuItem
    @State private var presentGrid:Bool = false
    
    var body: some View {
        TabView {
            PhotoView()
                .tabItem {
                    Label("View", systemImage: "photo.fill")
                }
            VStack {
                HeaderView()
                    .cornerRadius(8)
                    .shadow(radius: 8)
                    .environment(\.colorScheme, .light)
                
                StatusBarView(showOrders: $showOrders, presentGrid: $presentGrid)
                
//                MenuItemView(item: $selectedItem, orders: orders)
//                    .padding()
//                    .background(.white.opacity(0.3), in: RoundedRectangle(cornerRadius: 8))
//                if presentGrid {
//                    MenuGridView(menu: menu, selectedItem: $selectedItem)
//                } else {
//                    MenuView(menu: menu, selectedItem: $selectedItem)
//                }
                MenuView2(menu: menu)
            }
            .tabItem {
                Label("Menu", systemImage: "cart")
            }
            
            VStack {
                HeaderView()
                    .cornerRadius(8)
                    .shadow(radius: 8)
                    .environment(\.colorScheme, .light)
                
                StatusBarView(showOrders: $showOrders, presentGrid: $presentGrid)
                
                OrderView(orders: orders)
            }
            .tabItem {
                Label("Order", systemImage: "cart")
            }
        }
//        .padding() 
        .background(LinearGradient(colors: [Color(.colors1), .blue, Color(.colors0).opacity(0.4), .white], startPoint: .topLeading, endPoint: .bottomTrailing))
        //        .padding()
        .environmentObject(orders)
    }
}

#Preview {
    ContentView(menu: MenuModel().menu)
    //            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

//MARK: Preview can also be written like this in xcode 14.3 or below
//struct ContentView_preview: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
