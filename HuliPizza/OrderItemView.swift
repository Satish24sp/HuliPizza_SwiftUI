//
//  OrderItemView.swift
//  HuliPizza
//
//  Created by Satish Thakur on 09/10/23.
//

import SwiftUI

struct OrderItemView: View {
    @Binding var orderItem: OrderItem
    @State private var quantity = 1
    @State private var doubleIngredient = false
    @State var pizzaCrust: PizzaCrust  // make public to use it in other view or previews
    @State private var name:String = ""
    @State private var comments:String = ""
    
    init(orderItem: Binding<OrderItem>, pizzaCrust: PizzaCrust) {
        self._orderItem = orderItem
        self.pizzaCrust = orderItem.item.crust.wrappedValue
    }
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            Toggle(isOn: $doubleIngredient, label: {
                Text("Double Ingredient: " + (doubleIngredient ? "Yes" : "No"))
            })
            
            Stepper(value: $quantity, in: 1...10) {
                Text("\(quantity) " + (quantity == 1 ? "Pizza" : "Pizzas"))
            }
            
            Picker(selection: $pizzaCrust) {
                ForEach(PizzaCrust.allCases, id: \.self) { crust in
                    Text(crust.rawValue).tag(crust as PizzaCrust?)
                }
            } label: {
                Text("Pizza Crust")
            }
            .pickerStyle(.wheel)
            
            VStack {
                Text("Comments")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                TextEditor(text: $comments)
            }
            .clipShape(RoundedRectangle(cornerRadius: 3))
            .shadow(radius: 1)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    OrderItemView(orderItem: .constant(testOrderItem), pizzaCrust: testOrderItem.item.crust)
}
