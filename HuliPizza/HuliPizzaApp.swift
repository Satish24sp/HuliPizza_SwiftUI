//
//  HuliPizzaApp.swift
//  HuliPizza
//
//  Created by Satish Thakur on 30/09/23.
//

import SwiftUI

@main
struct HuliPizzaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(menu: MenuModel().menu)
        }
    }
}
