//
//  SplashScreen.swift
//  Natumedi
//
//  Created by Julia Kansbod on 2022-12-16.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        
        if isActive {
            ContentView(quotesData: Quotes(affirmation: "Loading..."))
        } else {
            
            VStack{
                
                ZStack {
                    
                    Image("SplashScreen")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        HStack {
                            Circle()
                                .fill(.black)
                                .frame(width: 12, height: 12)
                            Text("Affirme")
                                .font(Font.custom("Italiana-Regular", size: 40))
                                .foregroundColor(.black)
                            Circle()
                                .fill(.black)
                                .frame(width: 15, height: 15)
                        }
                    }
                    
                    
                }
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
            
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
