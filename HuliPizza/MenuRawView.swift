//
//  MenuRawView.swift
//  HuliPizza
//
//  Created by Satish Thakur on 01/10/23.
//

import SwiftUI

struct MenuRawView: View {
    var item: MenuItem
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            if let image = UIImage(named: "images-\(item.id%10)") {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .padding(.trailing, -20)
                    .padding(.leading, -15)
            } else {
                Image(.mPizza).resizable().aspectRatio(contentMode: .fit)
            }
            //                        Image(systemName: "\(item).circle.fill")
            //                            .font(.largeTitle)
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(item.name)
                        .font(.headline)
                    Spacer()
                    Text(item.price, format: .currency(code: "USD"))
                }
//                Text("Pizza Description")
//                    .font(.subheadline)
                RatingsView(rating: item.rating)
            }.padding()
        }
        .padding()
    }
}

#Preview {
    MenuRawView(item: testMenuItem)
}
