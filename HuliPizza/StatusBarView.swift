//
//  StatusBarView.swift
//  HuliPizza
//
//  Created by Satish Thakur on 09/10/23.
//

import SwiftUI

struct StatusBarView: View {
    @Binding var showOrders: Bool
    @EnvironmentObject var orders: OrderModel
    @Binding var presentGrid:Bool

    var body: some View {
        HStack {
            Text("\(orders.orderItems.count) orders")
            Spacer()
            Button{
                showOrders.toggle()
            } label: {
                Image(systemName: showOrders ? "cart" : "menucard")
            }
            
            if !showOrders {
                Button{
                    presentGrid.toggle()
                } label: {
                    Image(systemName: presentGrid ? "square.grid.3x2" : "list.bullet")
                }
            .padding(.leading, 10)
            }
            
            Spacer()
            
            Label {
                Text(orders.orderTotal, format: .currency(code: "USD"))
                    .fontWeight(.bold)
            } icon: {
                Image(systemName: orders.orderItems.isEmpty ? "cart" : "cart.fill")
            }
        }
        .foregroundStyle(.white)
        .font(.title2)

    }
}

#Preview {
    StatusBarView(showOrders: .constant(false), presentGrid: .constant(true)).environmentObject(OrderModel())
        .background(.black)    //aaded just to check preview screen
}
