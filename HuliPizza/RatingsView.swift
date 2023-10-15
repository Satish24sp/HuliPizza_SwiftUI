//
//  RatingsView.swift
//  HuliPizza
//
//  Created by Satish Thakur on 01/10/23.
//

import SwiftUI

struct RatingsView: View {
    var rating: Int
    var body: some View {
        HStack {
            ForEach(1...6, id: \.self) { rate in
                Image(systemName: (rate <= rating ? "fork.knife.circle.fill" : "circle"))
            }
        }
    }
}

#Preview {
    RatingsView(rating: 1)
}
