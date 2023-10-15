//
//  HeaderView.swift
//  HuliPizza
//
//  Created by Satish Thakur on 01/10/23.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var orders: OrderModel
    @Environment(\.verticalSizeClass) var vSizeClass: UserInterfaceSizeClass?
    var body: some View {
        VStack {
            if vSizeClass != .compact {
                ZStack(alignment: .bottomTrailing) {
                    Image(.pizzaPoster)
                        .resizable()
                        .scaledToFit()
                    //                .scaledToFill()
                    //                .ignoresSafeArea()
                    Text(" Huli Pizza Company ")
                        .font(.custom("Times New Roman", size: 18, relativeTo: .body))
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.semibold)
//                        .foregroundStyle(.white)
                }
                .padding(.bottom)
            } else {
                HStack(alignment: .bottom) {
                    Image(.pizzaPoster)
                        .resizable()
                        .scaledToFit()
                    //                .scaledToFill()
                    //                .ignoresSafeArea()
                    Text(" Huli Pizza Company ")
                        .font(.custom("Times New Roman", size: 18, relativeTo: .body))
                        .foregroundStyle(.colors1)
                        .fontWeight(.heavy)
                    
                }
            }
//            Label {
//                Text(orders.orderTotal, format: .currency(code: "USD"))
//                    .fontWeight(.bold)
//            } icon: {
//                Image(systemName: orders.orderItems.isEmpty ? "cart" : "cart.fill")
//            }

        }
        .backgroundStyle(.ultraThinMaterial)
        Spacer()
    }
}

struct HeaderView_preview: PreviewProvider {
    static var previews: some View {
        HeaderView().environmentObject(OrderModel())
    }
}
