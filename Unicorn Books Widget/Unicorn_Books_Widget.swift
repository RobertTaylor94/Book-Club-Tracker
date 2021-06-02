//
//  Unicorn_Books_Widget.swift
//  Unicorn Books Widget
//
//  Created by Robert Taylor on 02/06/2021.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), book: WidgetBook(title: "Add Your First Book!", progress: 0.0))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), book: WidgetBook(title: "Add Your First Book!", progress: 0.0))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate,
                                    book: WidgetBook(
                                        title: "\(UserDefaults(suiteName: "group.com.roberttaylor.Unicorn-Books")!.object(forKey: "title") as! String)",
                                        progress: UserDefaults(suiteName: "group.com.roberttaylor.Unicorn-Books")!.object(forKey: "progress") as! Float))
            
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let book: WidgetBook
}

struct Unicorn_Books_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            VStack {
                Spacer()
                Text(entry.book.title)
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                Spacer()
                Text("\(String(format: "%.0f", entry.book.progress*100))%")
                    .foregroundColor(.white)
                Spacer()
            }.padding()
            
        }
    }
}

@main
struct Unicorn_Books_Widget: Widget {
    let kind: String = "Unicorn_Books_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Unicorn_Books_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Book Club Widget")
        .description("Shows your current book and its progress.")
    }
}

struct Unicorn_Books_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Unicorn_Books_WidgetEntryView(entry: SimpleEntry(date: Date(), book: WidgetBook(title: "Title", progress: 0.1)))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
