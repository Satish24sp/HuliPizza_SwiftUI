//
//  OrderView.swift
//  HuliPizza
//
//  Created by Satish Thakur on 01/10/23.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var orders: OrderModel
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach($orders.orderItems) { $order in //$ used to make it as optional
                        NavigationLink(value: order) {
                            OrderRawView(order: $order)
                                .padding(.bottom, 8)
                                .padding([.leading, .trailing], 5)
                                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                        }
                        .navigationDestination(for: OrderItem.self) { order in
                            OrderDetailView(orderItem: $order, presentSheet: .constant(false), newOrder: .constant(false))
                        }
                        .navigationTitle("Your Order")
                    }
                    .onDelete(perform: { indexSet in
                        orders.orderItems.remove(atOffsets: indexSet)
                    })
                    .onMove { from, to in
                        orders.orderItems.move(fromOffsets: from, toOffset: to)
                    }
                }
            }
//            .padding(.top, 75)
//            Button("Delete Order") {
//                if !orders.orderItems.isEmpty {
//                    orders.removeLast()
//                }
//            }
//            .padding(5)
//            .background(.red, in: Capsule())
//            .foregroundStyle(.white)
//            .padding(10)
        }
        .padding()
        .background(.ultraThinMaterial)
        
    }
}

#Preview {
    OrderView(orders: OrderModel())
}
