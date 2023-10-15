//
//  MenuGridView.swift
//  HuliPizza
//
//  Created by Satish Thakur on 09/10/23.
//

import SwiftUI

struct MenuGridView: View {
    
    var menu:[MenuItem]
    @Binding var selectedItem: MenuItem
    let columnLayout = Array(repeating: GridItem(), count: 3)
    let favColumnLayout = Array(repeating: GridItem(), count: 5)
    
    @State private var favorites:[Int] = []
    
    func menu(id: Int) -> MenuItem {
        menu.first(where: {$0.id == id}) ?? noMenuItem
    }
    
    @Namespace private var nspace
    
    
    var body: some View {
        VStack {
            LazyVGrid(columns: favColumnLayout) {
                ForEach(favorites.sorted(), id: \.self) { id in
                    FavoriteTileView(menuItem: menu(id: id))
                        .matchedGeometryEffect(id: id, in: nspace)
                        .onTapGesture {
                            selectedItem = menu(id: id)
                        }
                        .onLongPressGesture {
                            if let index = favorites.firstIndex(where: {$0 == id}) {
                                favorites.remove(at: index)
                            }
                        }
                }
            }
            
//            Text(selectedItem.name)
            
            ScrollView {
                LazyVGrid(columns: columnLayout) {
                    ForEach(menu) { item in
                        if !favorites.contains(item.id) {
                            MenuItemTileView(menuItem: item)
                                .animation(.easeOut, value: favorites)
                                .matchedGeometryEffect(id: item.id, in: nspace)
                                .onTapGesture(count: 2) {
                                    if !favorites.contains(item.id) {
                                        withAnimation(.easeInOut) {
                                            favorites.append(item.id)
                                        }
                                    }
                                }
                                .onTapGesture {
                                    selectedItem = item
                                }
                                .onLongPressGesture {
                                    selectedItem = noMenuItem
                                }
                        }
                    }
                }
            }
        }
        .padding()
        .animation(.easeOut(duration: 0.5), value: favorites)
    }
}

#Preview {
    MenuGridView(menu: MenuModel().menu, selectedItem: .constant(testMenuItem))
}
