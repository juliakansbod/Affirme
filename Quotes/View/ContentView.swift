//
//  ContentView.swift
//  Quotes
//
//  Created by Julia Kansbod on 2022-12-16.
//

import SwiftUI

struct ContentView: View {
    
    @State var quotesData: Quotes
    @State var dataLoaded = false
    
    var body: some View {
        
        ZStack{
            Image("bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Circle()
                        .fill(.black)
                        .frame(width: 5, height: 5)
                    Text("Affirme")
                        .font(Font.custom("Italiana-Regular", size: 20))
                    Circle()
                        .fill(.black)
                        .frame(width: 5, height: 5)
                }
                
                Spacer()
                
                Text(quotesData.affirmation + ".")
                    .font(Font.custom("Italiana-Regular", size: 27))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    withAnimation{
                        loadData()
                    }
                } label: {
                    Image(systemName: "arrow.right")
                }
                
            }
            .onAppear(){
                loadData()
            }
            .padding()
            .padding(.vertical, 20)
            .foregroundColor(.black)
        }
        
    }
    
    //MARK: URL Fetching from API
    func loadData(){
        
        dataLoaded = false
        guard let url = URL(string: "https://www.affirmations.dev/") else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            if let decodedData = try? JSONDecoder().decode(Quotes.self, from: data) {
                DispatchQueue.main.async {
                    self.quotesData = decodedData
                    dataLoaded = true
                }
            }
        }
        .resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(quotesData: Quotes(affirmation: "Loading..."))
    }
}
