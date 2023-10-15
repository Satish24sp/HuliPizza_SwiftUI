//
//  OrderRawView.swift
//  HuliPizza
//
//  Created by Satish Thakur on 01/10/23.
//

import SwiftUI

struct OrderRawView: View {
    @Binding var order: OrderItem
    var body: some View {
        VStack {
            HStack {
                Text(order.item.name)
                Text(":- \(order.preferredCrust.rawValue)")
                if order.extraIngredients {
                    Image(systemName: "2.circle")
                }
                Spacer()
                Text(order.name)
            }
            HStack(alignment: .firstTextBaseline) {
                Text(order.quantity, format: .number)
                Text(order.item.price, format: .currency(code: "USD"))
                Spacer()
                Text(order.extPrice, format: .currency(code: "USD"))
                    .fontWeight(.semibold)
            }
//            .padding(5)
//            .background(.regularMaterial)
//            .cornerRadius(8)
//            .shadow(radius: 4)
        }
    }
}

#Preview {
    OrderRawView(order: .constant(testOrderItem))
}
