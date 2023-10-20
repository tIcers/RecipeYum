//
//  HeaderView.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-10-16.
//

import SwiftUI

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let login_image : Image
    
    var body: some View {
        ZStack {
            login_image
//            RoundedRectangle(cornerRadius : 0)
//                .foregroundColor(backColor)
//                .rotationEffect(Angle(degrees: angle))
            VStack {
                Text(title)
                    .font(.system(size:50))
                    .foregroundColor(.white)
                    .bold()
                Text(subtitle)
                    .font(.system(size:30))
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(.top, 30)
            
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 300)
        .offset(y: -105)
    }
}

#Preview {
    HeaderView(title: "Title", subtitle: "Subtitle", login_image: Image("login_img"))
}
