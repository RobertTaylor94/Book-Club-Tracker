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
        SimpleEntry(date: Date(), book: WidgetBook(title: "Add Your First Book!", progress: 0.0, bookImgUrl: ""))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), book: WidgetBook(title: "Add Your First Book!", progress: 0.0, bookImgUrl: ""))
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
                                        progress: UserDefaults(suiteName: "group.com.roberttaylor.Unicorn-Books")!.object(forKey: "progress") as! Float,
                                        bookImgUrl: UserDefaults(suiteName: "group.com.roberttaylor.Unicorn-Books")!.object(forKey: "imgUrl") as! String))
            
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
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            BooksWidgetViewSmall(title: entry.book.title, progress: entry.book.progress)
        case .systemMedium:
            BooksWidgetViewMedium(title: entry.book.title, progress: entry.book.progress, bookImgUrl: entry.book.bookImgUrl)
        case .systemLarge:
            BooksWidgetViewLarge(title: entry.book.title, progress: entry.book.progress)
        @unknown default:
            EmptyView()
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
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct Unicorn_Books_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Unicorn_Books_WidgetEntryView(entry: SimpleEntry(date: Date(), book: WidgetBook(title: "Title", progress: 0.1, bookImgUrl: "")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        Unicorn_Books_WidgetEntryView(entry: SimpleEntry(date: Date(), book: WidgetBook(title: "Title", progress: 0.1, bookImgUrl: "")))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        Unicorn_Books_WidgetEntryView(entry: SimpleEntry(date: Date(), book: WidgetBook(title: "Title", progress: 0.1, bookImgUrl: "")))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
