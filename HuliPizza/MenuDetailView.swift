//
//  MenuDetailView.swift
//  HuliPizza
//
//  Created by Steven Lipton on 11/17/22.
//

import SwiftUI

struct MenuDetailView: View {
    @State private var addedItem:Bool = false
    @Binding var item:MenuItem?
    @EnvironmentObject var order:OrderModel
    @State var pizzaCrust:PizzaCrust? = nil
    @State private var doubleIngredient:Bool = false
    @State private  var quantity:Int = 1
    @State private var name:String = ""
    @State var orderItem = OrderItem(id: -99, item: noMenuItem)
    
    func updateOrder(){
        orderItem.quantity = quantity
        orderItem.extraIngredients = doubleIngredient
        orderItem.name = name
        orderItem.preferredCrust = pizzaCrust ?? .neopolitan
    }
    
    var body: some View {
        VStack {
            // The pizza description
            HStack {
                VStack(alignment:.trailing) {
                    Text(item?.name ?? "Huli Pizza Company")
                        .font(.title)
                        .fontWeight(.semibold)
                        
                        .padding()
                    
                    ScrollView {
                        Text(item?.description ?? "We're a bunch of surfers who love pizza and Island food. Explore our favorites here in our restaurant and food trucks")
                            .font(.custom("Georgia",size: 18,relativeTo: .body))
                    }
                    HStack{
                        RatingsView(rating: item?.rating ?? 0 )
                            .padding(.leading,50)
                        Spacer()
                        Text(item?.price ?? 0,format: .currency(code: "USD"))
                    }
                    Spacer()
                }
                .padding(.leading,50)
                .foregroundStyle(.ultraThickMaterial)
                if let image = UIImage(named: "images-\(item?.id ?? -1)"){
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 120)
//                        .frame(height: 120)
                        .scaledToFit()
                        .padding([.top,.bottom],5)
                    //                    .clipShape(RoundedRectangle(cornerRadius:10))
                        .cornerRadius(15)
                    
                } else {
                    Image(.mPizza)
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(180))
                }
                
            }
            
            .frame(maxHeight:200)
            
            .background(.linearGradient(colors: [.colors0,.colors1 .opacity(0.1)], startPoint: .leading, endPoint: .trailing), in:Capsule())
            .shadow(color:.teal,radius: 5,x:8,y:8)
            .padding(.leading,30)
            //customer changes
            HStack{
            /*Note: You will get error:
            Picker: the selection "nil" is invalid and does not have an associated tag, this will give undefined results.
             In L82, $pizzaCrust is optional but in L84 the tag crust is non optional so to fix this, change tag(crust) to tag(crust as PizzaCrust?)
             */

                Picker(selection: $pizzaCrust ) {
                        ForEach(PizzaCrust.allCases,id:\.self){crust in
                            Text(crust.rawValue).tag(crust as PizzaCrust?)
                        }
                    } label: {
                        Text("Pizza Crust")

                    }
//                    .padding(.leading)
                    .pickerStyle(MenuPickerStyle())
                    .foregroundColor(.black)
                    .background(.ultraThickMaterial)
               Spacer()
                VStack {
                    Toggle(isOn: $doubleIngredient){
                            Text((doubleIngredient ? "Double Toppings" : "Single Toppings"))
                    }
                    Stepper(value: $quantity, in: 1...10 ){
                        Text("\(quantity) " + (quantity == 1 ? "pizza" : "pizzas"))
                    }
                }
                .padding(.trailing,-30)
            }
            .padding(20)
            .padding([.trailing],40)
            .background(.regularMaterial)
            .cornerRadius(10)
            .padding()
            Spacer()
            //Pizza view of ordered pizza
            VStack{
                HStack{
                    Text("Order for " + (name == "" ? "You" : name ) )
                        .font(.largeTitle)
                    Spacer(minLength: 50)
                    Button{
                        orderItem = OrderItem(id: -999, item: item ?? noMenuItem)
                       updateOrder()
                        order.addOrder(orderItem: orderItem)
                    } label:{
                        Spacer()
                        Text((item?.price ?? 0) * Double(quantity) ,format:.currency(code: "USD")).font(.title3).bold()
                        Image(systemName: addedItem ? "cart.fill.badge.plus" : "cart.badge.plus")
                        Spacer()
                    }
                    .disabled(item?.id ?? -99 < 0 )
                    .padding()
                    .background(.red,in:Capsule())
                    .foregroundStyle(.white)
                    .padding(5)
                }
                .padding()
                .background(.thinMaterial, in: Capsule())
                HStack(alignment:.top){
                    VStack(alignment:.leading){
                        Text(item?.name ?? "Huli Pizza")
                            .font(.largeTitle)
                        
                        Text(pizzaCrust?.rawValue ?? "Neopolitan")
                        Text( doubleIngredient ? "Double Toppings" : "")
                        Text("\(quantity)" + (quantity == 1 ? " pizza" : " pizzas") )
                            TextField("Pizza for Who?", text:$name)
                                .padding()
                            
                        
                    }
                    .animation(.easeIn, value: doubleIngredient)
                    .font(.title)
                    .padding()
                    .padding(.trailing,20)
                    if let image = UIImage(named: "images-\(item?.id ?? -1)"){
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 120)
                            .frame(height: 120)
                            .scaledToFit()
                            .padding([.top,.bottom],5)
                        //                    .clipShape(RoundedRectangle(cornerRadius:10))
                            .cornerRadius(15)
                        
                    } else {
                        Image(.mPizza)
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(.degrees(180))
                    }
                    
                }
                Spacer()
                
            }
          
            
            
            
            
        }
        .background(.linearGradient(colors: [.white,.blue,.surf.opacity(0.3),.surf], startPoint: .topLeading, endPoint: .bottom))
        .onChange(of: item) { item in
            quantity = 1
            pizzaCrust = item?.crust ?? PizzaCrust.calzone
        }
    }
    
}

struct MenuDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MenuDetailView(item:.constant(testMenuItem)).environmentObject(OrderModel())
    }
}
