//
//  MenuView.swift
//  HuliPizza
//
//  Created by Satish Thakur on 01/10/23.
//

import SwiftUI

struct MenuView: View {
    var menu: [MenuItem]
    @Binding var selectedItem: MenuItem
    var body: some View {
//        ScrollView {
//            ForEach(menu) {item in
//                MenuRawView(item: item)
//            }
//        }
        
        List(MenuCategory.allCases, id: \.self) { category in
            Section {
                ForEach(menu.filter({$0.category == category})) {item in
                    MenuRawView(item: item)
                        .onTapGesture {
                            selectedItem = item
                        }
                }
            } header: {
                Text(category.rawValue)
            }
        }
        
    }
}

#Preview {
    MenuView(menu: MenuModel().menu, selectedItem: .constant(testMenuItem))
}
