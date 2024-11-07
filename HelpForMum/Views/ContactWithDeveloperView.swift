//
//  ContactWithDeveloperView.swift
//  HelpForMum
//
//  Created by Настя on 05.11.2024.
//

import SwiftUI

struct ContactWithDeveloperView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                openMail(emailTo: "nastya.zubarevich@gmail.com")
            } label: {
                Text("Связаться с разработчиком через почту.")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .padding(20)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding()
        }
    }
    
    func openMail(emailTo:String) {
        if let url = URL(string: "mailto:\(emailTo)"),
           UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

#Preview {
    ContactWithDeveloperView()
}
