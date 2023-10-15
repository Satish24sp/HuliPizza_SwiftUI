//
//  MenuItemView.swift
//  HuliPizza
//
//  Created by Satish Thakur on 01/10/23.
//

import SwiftUI

struct MenuItemView: View {
    @State private var addedItem: Bool = false
    @Binding var item: MenuItem
    @ObservedObject var orders: OrderModel
    @State var presentAlert: Bool = false
    @State private var newOrder: Bool = true
    @State private var order = noOrderItem
    var body: some View {
        VStack {
            if let image = UIImage(named: "images-\(item.id%10)") {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .cornerRadius(8)
                    .shadow(color: .yellow , radius: 8, x: 4, y: 4)
            } else {
                Image(.mPizza)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                    .fontWeight(.bold)
//                    .foregroundStyle(Color(red: 60.67, green: 0.0, blue: 0.0))
                    .foregroundStyle(Color(.colors0))
//                    .background(LinearGradient(colors: [.yellow, .black], startPoint: .leading, endPoint: .trailing), in: .capsule)
                ScrollView {
                    Text(item.description)
                        .font(.subheadline)
//                        .font(.custom("Georgia", fixedSize: 18)) //same font size in different varients
                        .font(.custom("Georgia", size: 18)) //font size relative to body in different varients
//                        .font(.custom("Georgia", size: 18, relativeTo: .body)) //font size relative to your custom style in different varients
                }
                
            }
            
            Button{
                order = OrderItem(id: -999, item: item)
                presentAlert = true
            } label: {
                Spacer()
                Text(item.price, format: .currency(code: "USD")).bold()
                Image(systemName: addedItem ? "cart.fill.badge.plus" : "cart.badge.plus")
                Spacer()
            }
            .disabled(item.id < 0)
            .padding()
            .background(.red, in: Capsule())
            .foregroundStyle(.white)
//            .alert("Buy a \(item.name)", isPresented: $presentAlert){
//                Button("No", role: .cancel){}
//                Button("Yes") {
//                    addedItem = true
//                    orders.addOrder(item, quantity: 1)
//                }
//                Button("Make it a double") {
//                    addedItem = true
//                    orders.addOrder(item, quantity: 2)
//                }
//            }
            
            .sheet(isPresented: $presentAlert) {
                addedItem = true
            } content: {
                OrderDetailView(orderItem: $order, presentSheet: $presentAlert, newOrder: $newOrder)
            }
        }
    }
}

#Preview {
    MenuItemView(item: .constant(testMenuItem), orders: OrderModel())
}
