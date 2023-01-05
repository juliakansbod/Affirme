//
//  QuotesWidget.swift
//  QuotesWidget
//
//  Created by Julia Kansbod on 2022-12-16.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> Model {
        Model(date: Date(), quotesData: Quotes.placeholderData)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Model) -> ()) {
        let entry = Model(date: Date(), quotesData: Quotes.placeholderData)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        getData{ (modelData) in
            
            let date = Date()
            let data = Model(date: date, quotesData: modelData)
            
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: date)
            
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
            
            completion(timeline)
        }
    }
}

func getData(completion: @escaping (Quotes)->()){
    
    let url = "https://www.affirmations.dev/"
    let session = URLSession(configuration: .default)
    
    session.dataTask(with: URL(string: url)!) { data, _,err in
        if err != nil{
            print(err!)
            return
        }
        
        do{
            let jsonData = try JSONDecoder().decode(Quotes.self, from: data!)
            completion(jsonData)
        } catch {
            print(err!)
        }
    }.resume()
    
}

struct Model: TimelineEntry {
    let date: Date
    var quotesData: Quotes
}

struct QuotesWidgetEntryView : View {
    
    var entry: Model

    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text(entry.quotesData.affirmation + ".")
                    .foregroundColor(.white)
                    .font(Font.custom("Italiana-Regular", size: 27))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 250)
            }
        }
    }
}

@main
struct QuotesWidget: Widget {
    let kind: String = "QuotesWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            QuotesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Affirme Widget")
        .description("Displays affirmations.")
        .supportedFamilies([.systemLarge])
    }
}

struct QuotesWidget_Previews: PreviewProvider {
    static var previews: some View {
        QuotesWidgetEntryView(entry: Model(date: Date(), quotesData: Quotes.placeholderData))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
